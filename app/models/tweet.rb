class Tweet < ActiveRecord::Base
  include Broadcast
  attr_accessible :content, :twitter_username, :twitter_user_image, :deal_id, :user_id, :link
  belongs_to :deal
  belongs_to :user
  has_many :responses

  after_create :set_user_id
  after_create :broadcast_tweet

  def find_or_create_user
    User.find_or_create_by_twitter_username(self.twitter_username)
  end

  def set_user_id
    user_id = find_or_create_user.id
    self.update_attributes(:user_id => user_id)
  end

  def broadcast_tweet
    broadcast "/tweets/new", self
  end
end