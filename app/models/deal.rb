class Deal < ActiveRecord::Base
  attr_accessible :link, :purchased, :image

  has_many :tweets
end
