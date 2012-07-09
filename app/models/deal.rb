class Deal < ActiveRecord::Base
  attr_accessible :link, :purchased, :image, :title

  after_create :broadcast_deal

  has_many :tweets

  def broadcast_deal
  	if Rails.env.production?
    	Pusher['deals'].trigger!('new_deal', self)
    else
    	Pusher['test_deals'].trigger!('test_new_deal', self)
    end
  end
end
