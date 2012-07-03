class TweetResponsesController < ApplicationController

	def new
		@tweet_response = TweetResponse.new
		@tweet_response.tweet = Tweet.find(params[:format])
	end

	def create
		@tweet_response = TweetResponse.new(params[:tweet_response])
		if @tweet_response.send_to_twitter
			render :text => "Response sent successfully"
		else
			render :text => "Response was not sent"
		end
	end
end
