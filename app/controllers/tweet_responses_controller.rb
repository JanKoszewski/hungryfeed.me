class TweetResponsesController < ApplicationController

	def new
		@tweet_response = TweetResponse.new
		@tweet_response.tweet = Tweet.find(params[:format])
	end

	def create
		@tweet_response = TweetResponse.new(params[:tweet_response])
		if @tweet_response.send_to_twitter
			flash[:notice] = "Response sent successfully"
			render :partial => "clear_form"
		else
      flash[:notice] = "Response was not sent"
      render :partial => "clear_form"
		end
	end
end
