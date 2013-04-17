class CreateTweets < ActiveRecord::Migration

  def change
    create_table :tweets do |t|
      t.string    :query
      t.string    :tweet_id
      t.string    :user_id
      t.string    :name
      t.string    :screen_name
      t.string    :profile_image_url
      t.string    :tweet
      t.datetime  :tweet_created_on
      t.datetime  :created_at
    end

    add_index :tweets, [:query]
    add_index :tweets, [:tweet_id], :unique => true
  end

end