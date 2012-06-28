class TweetResponsesController < ApplicationController

	def new 
		@tweet_response = TweetResponse.new
	end

	def create
		@tweet_response = TweetResponse.new(:content => params[:content])
		if @tweet_response.save
			render :text => "Response sent successfully"
		else
			render :text => "Response was not sent"
		end
	end
end
