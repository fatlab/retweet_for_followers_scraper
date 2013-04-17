# encoding: UTF-8

# START IT UP...
APP_MODE = 'scraper'
APP_ROOT = File.expand_path(File.dirname(__FILE__))
DEBUG = true
TIME_START = Time.now

# Toggleable for testing purposes

require 'rubygems'
require 'bundler'

Bundler.require

require "#{APP_ROOT}/config.rb"

Twitter.configure do |config|
  config.consumer_key = APP_CONFIG['twitter']['consumer_key']
  config.consumer_secret = APP_CONFIG['twitter']['consumer_secret']
  config.oauth_token = APP_CONFIG['twitter']['oauth_token']
  config.oauth_token_secret = APP_CONFIG['twitter']['oauth_secret']
end


_heading('Twitter Retweet Search')

n = 0
['★RETWEET★IF★YOU★WANT★MORE★FOLLOWERS★'].each do |q|
  begin
    recent = Tweet.where('LOWER(query) = ?', q.downcase).order('tweet_id desc').first# rescue nil
    puts "since: #{recent && recent.tweet_id}"
    Twitter.search(q, :since_id => (recent && recent.tweet_id), :result_type => 'recent', :count => 100).results.map do |status|
      _debug("@#{status.from_user}: #{status.text}", 3)
      tweet = status[:text]
      status.urls.each{|u| tweet.gsub!(u.url, u.expanded_url)}
      t = Tweet.create(:query => q.downcase, :tweet_id => status.id, :tweet => tweet, :tweet_created_on => status.created_at, :user_id => status.user.id, :name => status.user.name, :screen_name => status.user.screen_name, :profile_image_url => status.user.profile_image_url)
      puts t.errors.message.inspect if t.new_record?
      n += 1
    end
  rescue => err
    _debug("ERROR: #{err}", 2)
  end
end


_debug("#{n} tweets found")
_debug('...done!')

exit
