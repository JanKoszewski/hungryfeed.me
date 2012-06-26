class Tweet < ActiveRecord::Base
  attr_accessible :content, :twitter_username, :twitter_user_image, :deal_id
  belongs_to :deal
  belongs_to :user

  def fetch_most_recent_tweets
    Resque.enqueue(TwitterFeed, self)
  end

end