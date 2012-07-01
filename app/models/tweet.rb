class Tweet < ActiveRecord::Base
  include Broadcast
  attr_accessible :content, :twitter_username, :twitter_user_image, :deal_id, :user_id, :link
  belongs_to :deal
  belongs_to :user
  has_many :tweet_responses
  has_many :deal_emails

  after_create :set_user_id
  after_create :broadcast_tweet
  after_create :email_deal

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

  def find_deal_emails
    deal_emails = DealEmail.where(:deal_id => self.deal.id)
    unless deal_emails.empty?
      deal_emails.each do |deal_email| 
        deal_email.update_attributes(:deal_id => self.deal.id, :tweet_id => self.id)
      end
    end
  end

  def email_deal
    find_deal_emails
    self.deal_emails.each do |deal_email|
      DealMailer.deal_email(deal_email).deliver
    end
  end
end