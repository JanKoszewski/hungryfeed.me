module TweetsHelper
  include AuthenticationsHelper
	def tweet_for_mustache(tweet)
    {
      id: tweet.id,
      deal_id: tweet.deal.id,
      url: tweet.link,
      respond_url: respond_url(tweet),
      respond_title: respond_title,
      twitter_username: tweet.twitter_username,
      twitter_user_image: tweet.twitter_user_image,
      button_class: button_class,
      klout_score: tweet.klout_score,
      content: tweet.content,
    }
  end

  private 

  def respond_title
    if signed_in?
      "Respond to tweet"  
    else 
      "Login with Twitter to Reply"
    end
  end

  def respond_url(tweet)
    if signed_in?
      Rails.application.routes.url_helpers.new_tweet_tweet_response_path(tweet)
    else
      login_path
    end
  end

  def button_class
    if signed_in?
      "iframe btn btn-primary cboxElement"
    else
      "btn btn-primary"
    end
  end

end
