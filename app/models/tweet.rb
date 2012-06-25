class Tweet < ActiveRecord::Base
  attr_accessible :content, :twitter_username, :twitter_user_image

  def fetch_most_recent_tweets
    Resque.enqueue(TwitterFeed, self)
  end

end