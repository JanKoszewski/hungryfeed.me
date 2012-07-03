class Deal < ActiveRecord::Base
  attr_accessible :link, :purchased, :image, :title

  after_save :broadcast_deal

  has_many :tweets

  def broadcast_deal
    Pusher['deals'].trigger!('new_deal', self)
  end
end
