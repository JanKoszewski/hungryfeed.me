class Tweet < ActiveRecord::Base
  attr_accessible :content, :twitter_username, :twitter_user_image, :deal_id, :user_id, :link, :klout_score
  belongs_to :deal
  belongs_to :user
  has_many :tweet_responses
  has_many :deal_emails

  before_create :set_user_id
  after_create :broadcast_tweet
  after_create :send_tweet_notificaiton

  def find_or_create_user
    User.find_or_create_by_twitter_username(self.twitter_username)
  end

  def set_user_id
    self.user_id = find_or_create_user.id
  end

  def broadcast_tweet
    self.update_attributes(:klout_score => self.user.klout_score)
    if Rails.env.production?
      Pusher['tweets'].trigger!('new_tweet', self)
    else
      Pusher['test_tweets'].trigger!('test_new_tweet', self)
    end
  end

  def find_deal_emails
    deal_emails = DealEmail.where(:link => self.deal.link)
    unless deal_emails.empty?
      deal_emails.each do |deal_email| 
        deal_email.update_attributes(:deal_id => self.deal.id, :tweet_id => self.id)
      end
    end
  end

  def send_tweet_notificaiton
    find_deal_emails
    self.deal_emails.each do |deal_email|
      DealMailer.deal_email(deal_email).deliver
    end
  end
end