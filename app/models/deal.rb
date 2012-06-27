class Deal < ActiveRecord::Base
	include Broadcast
  attr_accessible :link, :purchased, :image

  after_create :broadcast_deal

  has_many :tweets

  def broadcast_deal
    broadcast "/deals/new", self
  end
end
