class Deal < ActiveRecord::Base
	include Broadcast
  attr_accessible :link, :purchased, :image, :title

  after_save :broadcast_deal
  after_save :find_deal_emails
  after_save :email_deal

  has_many :tweets
  has_many :deal_emails

  def broadcast_deal
    broadcast "/deals/new", self
  end

  def find_deal_emails
    deal_emails = DealEmail.where(:deal_link => self.link)
    unless deal_emails.empty?
      deal_emails.each { |deal_email| deal_email.update_attributes(:deal_id => self.id) }
    end
  end

  def email_deal
  	self.deal_emails.each do |deal_email|
  		DealMailer.deal_email(deal_email).deliver
  	end
  end
end
