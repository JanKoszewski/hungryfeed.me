class DealEmailsController < ApplicationController

	def create
		@deal_email = DealEmail.where(params[:deal_email]).first_or_initialize
		if @deal_email.save
			flash[:notice] = "Email will be sent!"
		else
			flash[:notice] = "Cannot be sent!"
		end
	end
end
