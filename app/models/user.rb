require 'klout'

class User < ActiveRecord::Base
  has_many :authentications
  has_many :tweets
  has_many :tweet_responses
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable, :database_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :twitter_link, :twitter_username, :klout_score, :oauth_token, :oauth_token_secret

  before_save :set_klout_score
  before_save :set_twitter_link

  def broadcast_user
    Pusher['users'].trigger!('user_score', self)
  end

  def set_klout_score
    self.klout_score = self.find_klout_score
  end

  def set_twitter_link
    self.twitter_link = "https://twitter.com/#{self.twitter_username}"
  end

  def build_authentication(omniauth)
    self.authentications.build(:provider => omniauth ['provider'], 
                               :uid => omniauth['uid'], 
                               :access_token => omniauth["credentials"]["token"])
    self.oauth_token = omniauth["credentials"]["token"]
    self.oauth_token_secret = omniauth["credentials"]["secret"]
  end

  def find_klout_score
    begin
      klout_id = Klout::Identity.find_by_screen_name(self.twitter_username)
      Klout::User.new(klout_id.id).score.score.to_i
    rescue Exception
      0
    end
  end
end
