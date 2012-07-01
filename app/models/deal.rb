class Deal < ActiveRecord::Base
	include Broadcast
  attr_accessible :link, :purchased, :image, :title

  after_save :broadcast_deal

  has_many :tweets

  def broadcast_deal
    # broadcast "/deals/new", self
    Pusher['deals'].trigger!('new_deal', self)
  end
end
