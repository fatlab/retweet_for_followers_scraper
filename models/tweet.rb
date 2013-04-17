class Tweet < ActiveRecord::Base


  validates_presence_of :tweet_id
  validates_presence_of :user_id
  validates_presence_of :screen_name
  validates_presence_of :profile_image_url
  validates_presence_of :query
  validates_presence_of :tweet
  validates_presence_of :tweet_created_on


protected


end