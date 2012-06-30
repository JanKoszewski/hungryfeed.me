class DealEmail < ActiveRecord::Base
  attr_accessible :tweet_id, :email, :link
  belongs_to :tweet
end
