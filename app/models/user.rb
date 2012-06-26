require 'klout'

class User < ActiveRecord::Base
  has_many :authentications
  has_many :tweets
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable, :database_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :twitter_link, :twitter_username, :klout_score

  after_create :set_klout_score
  after_create :set_twitter_link

  def find_klout_score
    Klout.api_key = KLOUT_API_KEY
    klout_id = Klout::Identity.find_by_screen_name(self.twitter_username)
    klout_score = Klout::User.new(klout_id.id).score.score.to_i
  end

  def set_klout_score
    self.update_attributes(:klout_score => self.find_klout_score)
  end

  def set_twitter_link
    self.update_attributes(:twitter_link => "https://twitter.com/#{self.twitter_username}")
  end
end
