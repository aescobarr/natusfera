class BulkUserFile < Struct.new(:users_file, :user)

  class BulkUserFileException < StandardError
    attr_reader :reason, :row_count, :errors, :tag

    def initialize(reason, row_count = nil, errors = [], tag = nil)
      @reason    = reason
      @row_count = row_count unless row_count.nil?
      @tag       = tag unless tag.nil?

      if errors.empty?
        @errors = [reason]
      else
        @errors = errors
      end
    end
  end

  NAME_COLUMN=2
  NAME_1_COLUMN=0
  NAME_2_COLUMN=1

  BASE_COLUMN_COUNT = 4
  IMPORT_BATCH_SIZE = 1000
  MAX_ERROR_COUNT   = 100

  attr_accessor :users_file, :user

  def initialize(users_file,user)
    @users_file = users_file
    @user = user
    # Table where we will write the login name and password for each user
    @name_login_password = []

    unless @user.is_curator?
      e = BulkUserFileException.new('User has insufficient privileges for bulk load operation')
      Emailer.delay.bulk_users_error(user, File.basename(users_file), e)
    end
  end

  def perform
    begin
      validate_file
      import_file
      credentials_list = format_credentials_list
      Emailer.delay.bulk_users_success(@user, File.basename(@users_file), credentials_list)

    rescue BulkUserFileException,CSV::MalformedCSVError => e
      # Collate the errors into a hash for emailing
      error_details = collate_errors(e)

      # Email the uploader with exception details
      Emailer.delay.bulk_users_error(@user, File.basename(@users_file), error_details)
    end
  end

  def format_credentials_list
    retval = "This is the list of credentials for the new users:\n"
    @name_login_password.each do |entry|
      retval << "Name: #{entry[:name]}, UserName: #{entry[:login]}, Password: #{entry[:password]}\n"
    end
    retval
  end

  def import_file
    row_count = 2
    # Load the entire file and skip the header row
    csv = CSV.parse(open(@users_file, 'r:iso-8859-1:utf-8').read)
    csv.shift
    # Split the rows into groups of the IMPORT_BATCH_FILE to
    # minimize wasted time in the case of errors.
    csv.in_groups_of(IMPORT_BATCH_SIZE).each do |rows|
      ActiveRecord::Base.transaction do
        rows.each do |row|
          next if skip_row?(row)

          usr = create_user(row)
          project = Project.where(:slug => row[3].strip).first
          begin
            #save user
            usr.save!

            #assign user to project and save relationship
            pu = ProjectUser.create(:user => usr, :project => project)
            pu.save!

            row_count = row_count + 1
          rescue ActiveRecord::RecordInvalid => e
            raise BulkUserFileException.new('Invalid record encountered: ' + e.inspect + " " + safe_string_from_user(usr), row_count)
          end
        end
      end
    end
  end

  def safe_string_from_user(user)
    if user.nil?
      "Blank user"
    end
    ret=""
    unless user.name.nil?
      ret << user.name
    end
    unless user.login.nil?
      ret << " " + user.login
    end
    unless user.email.nil?
      ret << " " + user.email
    end
    # :time_zone => row[2].strip!,
    # :locale => row[3].strip!,
    # :password => long_pwd
    ret
  end

  def validate_file
    #Columns - Name, email, time_zone, locale
    rows = CSV.parse(open(@users_file, 'r:iso-8859-1:utf-8').read)
    rows.shift
    errors = []
    row_count = 1
    rows.each do |row|
      unless skip_row?(row)
        if row[1].blank?
          errors << BulkUserFileException.new("Mail can't be blank!: #{row[0]}", row_count + 1, [], "mail_not_blank")
        end
        login = get_login_from_name(row[0])
        user = User.where(login: login).first
        unless user.nil?
          errors << BulkUserFileException.new("User already exists: #{row[0]}", row_count + 1, [], "user_already_exists")
        end
        if row[3].blank?
          errors << BulkUserFileException.new("Project can't be blank!: #{row[0]}", row_count + 1, [], "project_not_blank")
        else
          p = Project.where(:slug => row[3].strip).first
          if p.nil?
            errors << BulkUserFileException.new("Project doesn't exist!: #{row[3]}", row_count + 1, [], "project_not_blank")
          end
        end
        if row.size != BASE_COLUMN_COUNT
          errors << BulkUserFileException.new("Incorrect number of columns: #{row[0]}", row_count + 1, [], "incorrect_field_number")
        end
      end
      row_count = row_count + 1
    end
    if errors.count > 0
      raise BulkUserFileException.new(
          I18n.t(:we_tried_to_process_your_upload_named_filename, :filename => File.basename(@users_file)),
          nil,
          errors)
    end
    if row_count == 0
      raise BulkUserFileException.new("The observation file '#{File.basename(@users_file)}' was empty.")
    end
  end

  def create_user(row)
    login = get_login_from_name(row[0])
    t_login = I18n.transliterate(login)
    long_pwd = elongate_string(t_login)
    u=User.new(
        :login => t_login,
        :email => row[1].strip,
        :name => row[0].strip,
        :time_zone => "Madrid",
        :locale => row[2].strip,
        :password => long_pwd
    )
    @name_login_password.push({:name => row[0].strip,:login => t_login, :password => long_pwd})
    u
  end

  def name_login_password
    @name_login_password
  end

  def elongate_string(t_login)
    i=1
    while t_login.length < 6 do
      t_login += i.to_s
      i += 1
    end
    t_login
  end

  def get_login_from_name(name)
    s=name.gsub(/\s+/m, ' ').split(" ")
    if s.length == 3
      s[NAME_COLUMN][0,1].downcase + s[NAME_1_COLUMN].downcase
    else
      s[NAME_COLUMN][0,1].downcase + s[NAME_COLUMN+1][0,1].downcase + s[NAME_1_COLUMN].downcase
    end
  end

  def skip_row?(row)
    row.blank? || !(row.first =~ /\A\s*#/).nil?
  end

  def collate_errors(exception)
    # enumerate the exceptions and collate error messages
    field_options = {}
    errors = {}
    exception.errors.each do |e|
      unless e.is_a?(String)
        if e.errors.is_a?(ActiveModel::Errors)
          e.errors.each do |field, error|
            errors[field] ||= {}
            full_error = e.errors.full_message(field, error)
            errors[field][full_error] ||= []
            errors[field][full_error] << e.row_count
          end
        elsif e.is_a?(ActiveRecord::RecordInvalid)
          e.record.errors.each do |field, error|
            full_error = e.record.errors.full_message(field, error)
            errors[field][full_error] ||= []
          end
        elsif !e.tag.nil?
          e.errors.each do |error|
            errors[e.tag] ||= {}
            errors[e.tag][error] ||= []
            errors[e.tag][error] << e.row_count
          end
        else
          e.errors.each do |error|
            errors['base'] ||= {}
            errors['base'][error] ||= []
            errors['base'][error] << e.row_count
          end
        end
      end
    end

    { :reason => exception.reason, :errors => errors.stringify_keys.sort_by { |k, v| k }, :field_options => field_options }
  end

end