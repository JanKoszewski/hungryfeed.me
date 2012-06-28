class TweetResponsesController < ApplicationController

	def new
		@tweet = Tweet.find(params[:format])
		@tweet_response = TweetResponse.new
	end

	def create
		@tweet_response = TweetResponse.new(params[:tweet_response])
		if @tweet_response.save
			render :text => "Response sent successfully"
		else
			render :text => "Response was not sent"
		end
	end
end
