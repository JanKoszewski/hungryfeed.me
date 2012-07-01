class DealEmail < ActiveRecord::Base
  attr_accessible :deal_id, :tweet_id, :email, :link
  belongs_to :tweet
  belongs_to :deal

  validates_presence_of :email
end
