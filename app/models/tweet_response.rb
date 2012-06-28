require 'twitter'

class TweetResponse < ActiveRecord::Base
  attr_accessible :content
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
		  config.oauth_token = self.user.oauth_token
		  config.oauth_token_secret = self.user.oauth_token
		end
  end
end
