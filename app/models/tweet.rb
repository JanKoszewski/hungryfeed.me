class Tweet < ActiveRecord::Base
  attr_accessible :content, :twitter_username, :twitter_user_image, :deal_id, :user_id, :link
  belongs_to :deal
  belongs_to :user

  def find_or_create_user
    User.find_or_create_by_twitter_username(self.twitter_username)
  end

  def set_user_id

  end

  def fetch_most_recent_tweets
    Resque.enqueue(TwitterFeed, self)
  end

end