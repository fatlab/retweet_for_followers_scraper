# encoding: UTF-8

Encoding.default_external = "UTF-8"
Encoding.default_internal = "UTF-8"


# PRE-DEFINED VARS
TIME_START    = Time.now
TEXT_COL_LEN  = 80

APP_ROOT  ||= File.expand_path(File.dirname(__FILE__))
APP_ENV   ||= 'scraper'
APP_MODE  ||= 'webapp'
DEBUG     ||= false


# REQUIRE MODULES/GEMS
%w{active_record mysql2 paperclip twitter yaml aws-sdk}.each{|r| require r}

# GET APP CONFIG
APP_CONFIG = YAML::load(File.open("#{APP_ROOT}/config.yml"))[APP_ENV]

# SETUP DATABASE
ActiveRecord::Base.establish_connection( YAML::load(File.open("#{APP_ROOT}/database.yml"))[APP_ENV] )

# REQUIRE DATABASE MODELS
Dir.glob("#{APP_ROOT}/models/*.rb").each{|r| require r}


# MISCELLANEOUS FUNCTIONS
def camelize(str)
  str.split('_').map {|w| w.capitalize}.join
end

def time_since_overall; time_since(TIME_START); end
def time_since(start=nil)
  @_time_since ||= TIME_START
  start ||= @_time_since
  @_time_since = Time.now

  "#{Time.now - start} seconds"
end


# TEXT FORMATTING
def _heading(str)
  puts "\n\n\n"
  _divider('#')
  puts " #{str.upcase} ".center(TEXT_COL_LEN)
  _divider('#')
end

def _subheading(str)
  puts "\n\n"
  puts " #{str.upcase} ".center(TEXT_COL_LEN, '-')
end

def _divider(str='-', t=false, b=false)
  puts "\n\n" if t
  puts "".center(TEXT_COL_LEN, str)
  puts "\n\n" if b
end

def _debug(msg, spaces=0)
  puts "#{'   ' * spaces}#{msg}" if defined?(DEBUG) && DEBUG
end