class BulkUserFile < Struct.new(:users_file, :user)

  attr_accessor :users_file, :user

  class BulkUserFileException < StandardError
    attr_reader :reason, :row_count, :errors
    def initialize(reason, row_count = nil, errors = [])
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

  def initialize(users_file,user)
    @users_file = users_file
    @user = user

    unless @user.is_curator?
      e = BulkUserFileException.new('User has insufficient privileges for bulk load operation')
      Emailer.delay.bulk_users_error(user, File.basename(users_file), e)
    end
  end

  def perform
    begin
      validate_file
      import_file
      Emailer.delay.bulk_users_success(@user, File.basename(@users_file))
    rescue BulkUserFileException => e
      # Collate the errors into a hash for emailing
      error_details = collate_errors(e)

      # Email the uploader with exception details
      Emailer.delay.bulk_users_error(@user, File.basename(@users_file), error_details)
    end
  end

  def import_file
    #Trivial import, does nothing
  end

  def validate_file
    #Trivial validation, always checks ok
  end

  def collate_errors(exception)
    # enumerate the exceptions and collate error messages
    field_options = {}
    errors = {}
    exception.errors.each do |e|
      if e.errors.is_a?(ActiveModel::Errors)
        e.errors.each do |field, error|
          errors[field] ||= {}
          full_error = e.errors.full_message(field, error)
          errors[field][full_error] ||= []
          errors[field][full_error] << e.row_count
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

    { :reason => exception.reason, :errors => errors.stringify_keys.sort_by { |k, v| k }, :field_options => field_options }
  end

end