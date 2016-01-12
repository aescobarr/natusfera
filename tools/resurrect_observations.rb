require 'rubygems'
require 'trollop'

opts = Trollop::options do
    banner <<-EOS
Delete duplicate listed taxa

Usage:
  rails runner tools/resurrect_observations.rb -u USER_ID

Options:
EOS
  opt :user, "User whose observations to resurret", :short => "-u", :type => :string
  opt :observed_on, "Observed date to resurrect observations from, format: YYYY-MM-DD", :short => "-d", :type => :string
  opt :created_on, "Created date to resurrect observations from, format: YYYY-MM-DD", :short => "-c", :type => :string
end

OPTS = opts

unless OPTS.user || OPTS.observed_on || OPTS.created_on
  puts "You must specify a user or a date"
  exit(0)
end

session_id = Digest::MD5.hexdigest(OPTS.to_s)
table_names = []
resurrection_cmds = []
update_statements = []

@where = []
if OPTS.user
  if @user = User.find_by_id(OPTS.user) || User.find_by_login(OPTS.user)
    @where << "observations.user_id = #{@user.id}"
  else
    puts "Couldn't find user matching '#{OPTS.user}'"
    exit(0)
  end
end

if OPTS.observed_on
  if @observed_on = Date.parse(OPTS.observed_on)
    @where += ["observed_on = '#{@observed_on}'"]
  else
    puts "Couldn't parse date from '#{OPTS.observed_on}'"
    exit(0)
  end
end

if OPTS.created_on
  if @created_on = Date.parse(OPTS.created_on)
    @where += ["observations.created_at::DATE = '#{@created_on}'"]
  else
    puts "Couldn't parse date from '#{OPTS.created_on}'"
    exit(0)
  end
end

system "rm -rf resurrect_#{session_id}*"

puts "Exporting from observations..."
fname = "resurrect_#{session_id}-observations.csv"
cmd = "psql inaturalist_production -c \"COPY (SELECT * FROM observations WHERE #{@where.join(' AND ')}) TO STDOUT WITH CSV\" > #{fname}"
puts "\t#{cmd}"
system cmd
resurrection_cmds << "psql inaturalist_production -c \"\\copy observations FROM '#{fname}' WITH CSV\""

# puts "Exporting from photos (except LocalPhotos, which are gone)..."
# fname = "resurrect_#{session_id}-photos.csv"
# cmd = "psql inaturalist_production -c \"COPY (SELECT * FROM photos WHERE user_id = #{user_id} AND type != 'LocalPhoto') TO STDOUT WITH CSV\" > #{fname}"
# puts "\t#{cmd}"
# system cmd
# resurrection_cmds << "psql inaturalist_production -c \"\\copy photos FROM '#{fname}' WITH CSV\""

update_statements = []

has_many_reflections = Observation.reflections.select{|k,v| v.macro == :has_many}
has_many_reflections.each do |k, reflection|
  # Avoid those pesky :through relats
  next unless reflection.klass.column_names.include?(reflection.foreign_key)
  next unless reflection.options[:dependent] == :destroy
  next if k.to_s == "observation_photos"
  puts "Exporting #{k}..."
  fname = "resurrect_#{session_id}-#{reflection.table_name}.csv"
  unless table_names.include?(reflection.table_name)
    system "test #{fname} || rm #{fname}"
  end
  sql = <<-SQL
    SELECT #{reflection.table_name}.* 
    FROM #{reflection.table_name} 
      JOIN observations ON #{reflection.table_name}.#{reflection.foreign_key} = observations.id
    WHERE #{@where.join(' AND ')}
  SQL
  cmd = "psql inaturalist_production -c \"COPY (#{sql}) TO STDOUT WITH CSV\" >> #{fname}"
  system cmd
  puts "\t#{cmd}"
  resurrection_cmds << "psql inaturalist_production -c \"\\copy #{reflection.table_name} FROM '#{fname}' WITH CSV\""
end

puts "Exporting from photos (except LocalPhotos, which are gone)..."
fname = "resurrect_#{session_id}-photos.csv"
w = @where + ["photos.type != 'LocalPhoto'"]
sql = <<-SQL
  SELECT photos.* 
  FROM photos 
    JOIN observation_photos ON observation_photos.photo_id = photos.id
    JOIN observations ON observations.id = observation_photos.observation_id
  WHERE #{w.join(' AND ')}
SQL
cmd = "psql inaturalist_production -c \"COPY (#{sql}) TO STDOUT WITH CSV\" > #{fname}"
puts "\t#{cmd}"
system cmd
resurrection_cmds << "psql inaturalist_production -c \"\\copy photos FROM '#{fname}' WITH CSV\""

puts "Exporting from observation_photos..."
fname = "resurrect_#{session_id}-observation_photos.csv"
w = @where + ["photos.type != 'LocalPhoto'"]
sql = <<-SQL
  SELECT observation_photos.* 
  FROM observation_photos 
    JOIN photos ON photos.id = observation_photos.photo_id
    JOIN observations ON observations.id = observation_photos.observation_id
  WHERE #{w.join(' AND ')}
SQL
cmd = "psql inaturalist_production -c \"COPY (#{sql}) TO STDOUT WITH CSV\" > #{fname}"
puts "\t#{cmd}"
system cmd
resurrection_cmds << "psql inaturalist_production -c \"\\copy photos FROM '#{fname}' WITH CSV\""

puts "Exporting from sounds..."
fname = "resurrect_#{session_id}-sounds.csv"
sql = <<-SQL
  SELECT sounds.* 
  FROM sounds 
    JOIN observation_sounds ON observation_sounds.sound_id = sounds.id
    JOIN observations ON observations.id = observation_sounds.observation_id
  WHERE #{@where.join(' AND ')}
SQL
cmd = "psql inaturalist_production -c \"COPY (#{sql}) TO STDOUT WITH CSV\" > #{fname}"
puts "\t#{cmd}"
system cmd
resurrection_cmds << "psql inaturalist_production -c \"\\copy sounds FROM '#{fname}' WITH CSV\""


cmd = "tar cvzf resurrect_#{session_id}.tgz resurrect_#{session_id}-*"
puts "Zipping it all up..."
puts "\t#{cmd}"
system cmd

cmd = "rm resurrect_#{session_id}-*"
puts "Cleaning up..."
puts "\t#{cmd}"
system cmd

puts
puts "Now run these commands (or something like them, depending on your setup):"
puts
puts <<-EOT
scp resurrect_#{session_id}.tgz inaturalist@taricha:deployment/production/current/
ssh -t inaturalist@taricha "cd deployment/production/current ; bash"
tar xzvf resurrect_#{session_id}.tgz
#{resurrection_cmds.uniq.join("\n")}
EOT
