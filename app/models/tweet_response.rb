require 'twitter'

class TweetResponse < ActiveRecord::Base
  attr_accessible :content, :user_id, :tweet_id
  belongs_to :user
  belongs_to :tweet

  after_create :send_to_twitter

  def send_to_twitter
  	configure_for_twitter.update(self.content)
  end

  def configure_for_twitter
  	Twitter.configure do |config|
  		config.consumer_key = TWITTER_CONSUMER_KEY
		  config.consumer_secret = TWITTER_CONSUMER_SECRET
		  config.oauth_token = User.find(self.user_id).oauth_token
		  config.oauth_token_secret = User.find(self.user_id).oauth_token_secret
		end
  end
end
