class Tweet < ActiveRecord::Base
  # attr_accessible :title, :body
  def fetch_most_recent_tweets
    Resque.enqueue(TwitterFeed, self)
  end
end
