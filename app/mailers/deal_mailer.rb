class DealMailer < ActionMailer::Base
  def deal_email(deal_email)
  	@deal_email = deal_email

  	default :from => "mehungryfeed@gmail.com"
    mail(:to => deal_email.email, :subject => "Your deal has been tweeted!")
  end
end
