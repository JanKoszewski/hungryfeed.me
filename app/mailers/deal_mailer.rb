class DealMailer < ActionMailer::Base
  default :from => "mehungryfeed@gmail.com"

  def deal_email(deal_email)
  	@deal_email = deal_email	
    mail(:to => deal_email.email, :subject => "Your deal has been tweeted!")
  end
end
