# Add country places and boundaries from naturalearthdata.org

def system_call(cmd)
  puts "Running #{cmd}"
  system cmd
  puts
end

# CONFIGURE
url = "http://www2.census.gov/geo/tiger/TIGER2012/STATE/tl_2012_us_state.zip"
shapefile_name = "tl_2012_us_state.shp"
test = false
#/ CONFIGURE

filename = File.basename(url)
tmp_path = File.join(Dir::tmpdir, "#{File.basename(__FILE__, ".*")}-#{Time.now.to_i}")
archive_path = "#{tmp_path}/#{filename}"
work_path = tmp_path
FileUtils.mkdir_p tmp_path, :mode => 0755

system_call "curl -Lo #{tmp_path}/#{filename} #{url}"
system_call "unzip -d #{tmp_path} #{tmp_path}/#{filename}"

Place.import_from_shapefile("#{work_path}/#{shapefile_name}", 
    :place_type_name => 'State', 
    :source => 'census',
    :skip_woeid => true,
    :test => test)
