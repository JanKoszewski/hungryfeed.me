class DealEmailsController < ApplicationController

	def create
		@deal_email = DealEmail.where(params[:deal_email]).first_or_initialize
		if @deal_email.save
			redirect_to tweets_path, flash[:notice] => "Will do!"
		else
			redirect_to tweets_path, flash[:notice] => "No comprende :("
		end
	end
end
