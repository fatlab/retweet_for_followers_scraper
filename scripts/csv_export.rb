# encoding: UTF-8

# START IT UP...
APP_MODE = 'scraper'
APP_ROOT = File.expand_path(File.dirname(__FILE__) + "/..")
DEBUG = true
TIME_START = Time.now

# Toggleable for testing purposes

require 'rubygems'
require 'bundler'

Bundler.require

require "#{APP_ROOT}/config.rb"


require 'csv'

CSV.open("output.csv", "w") do |csv|
  csv << ["Tweet ID", "Tweet", "Created", "Full Name", "Scren Name", "Profile Image URL"]
  Tweet.all.each do |t|
    csv << [t.tweet_id, t.tweet.gsub(/((\r)?\n)/, ' '), t.tweet_created_on, t.name, t.screen_name, t.profile_image_url]
  end
end
