class DealEmail < ActiveRecord::Base
  attr_accessible :deal_id, :email, :deal_link
  belongs_to :deal

  after_create :link_to_deal

  def link_to_deal
  	unless deal = Deal.where(:link => self.deal_link).empty?
  		self.deal_id = deal.id
  	end
  end
end
