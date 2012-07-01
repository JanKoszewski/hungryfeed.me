class DealEmailsController < ApplicationController

	def create
		session[:return_to] ||= request.referer
		@deal_email = DealEmail.where(params[:deal_email]).first_or_initialize
		if @deal_email.save
			redirect_to session[:return_to], flash[:notice] => "Will do!"
		else
			redirect_to session[:return_to], flash[:notice] => "No comprende :("
		end
	end
end
