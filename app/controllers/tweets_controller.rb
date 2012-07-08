class TweetsController < ApplicationController
	
  def index
    @tweets = Tweet.order("created_at DESC").limit(10)
    @tweets = @tweets.offset((params[:page].to_i-1)*10) if params[:page].present?
    respond_to do |format|
	    format.html
	    format.json do
	      render json: @tweets.map { |t| view_context.tweet_for_mustache(t) }
	    end
	  end
  end
end
