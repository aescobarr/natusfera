require 'csv'
require 'i18n'

def get_login_from_name(name)
  s=name.gsub(/\s+/m, ' ').split(" ")
  if s.length == 3
    s[NAME][0,1].downcase + s[NAME_1].downcase
  else
    s[NAME][0,1].downcase + s[NAME+1][0,1].downcase + s[NAME_1].downcase
  end
end

def elongate_password(t_login)
  i=1
  while t_login.length < 6 do
    t_login += i.to_s
    i += 1
  end
  t_login
end

def cleanup_users(csv) 
  csv.each do |row|
    h = row.to_hash
    login = get_login_from_name h["name"]
    t_login = I18n.transliterate(login)
    u = User.find_by_login(t_login.downcase)
    if u
      puts "Deleting user #{t_login}..."
      if u.delete
        puts "User #{t_login} deleted"
      else
        puts "User #{t_login} not deleted because #{u.errors.full_messages.to_sentence}"
      end
    else
      puts "User #{t_login} didn't exist"
    end
  end
end

def create_users(csv)
  puts "Creating new users..."
  csv.each do |row|
    h = row.to_hash
    login = get_login_from_name h["name"]
    t_login = I18n.transliterate(login)
    long_pwd = elongate_password t_login
    u=User.new(
      :login => t_login,
      :email => t_login + "@cami.com",
      :name => h["name"],
      :time_zone => h["time_zone"],
      :locale => h["locale"],
      :password => long_pwd
      )
    if u.save 
      puts "Created user #{u.login}"
    else
      puts "User #{u.login} not created because #{u.errors.full_messages.to_sentence}"
    end
  end
end

def check_project_members(csv)
  puts "Determining members in project..."
  distribution = Hash.new
  csv.each do |row|
    h = row.to_hash
    group = h["group"]
    if distribution.has_key?(group)
      distribution[group] << h["name"]
    else
      distribution.store(group,h["name"])
    end
  end
  puts distribution
end

def create_projects(csv)
  puts "Creating projects"
  created = Array.new
  csv.each do |row|
    h = row.to_hash
    group = h["group"]
    unless created.include? group
      created << group
      puts "Creating project Grup " + group
    end
  end
end

NAME=2
NAME_1=0
NAME_2=1

PARENT_PROJECT_ID=9

csv_text = File.read('/home/agusti/_inat_fecyt_2015_last/inaturalist/tools/test.csv')
csv = CSV.parse(csv_text, :headers => true, :col_sep => ';')

# cleanup_users csv
# create_users csv
create_projects csv
#check_project_members csv
