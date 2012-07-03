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
      user_link: tweet.user.twitter_link,
      content: tweet.content,
    }
  end

  def respond_title
    if signed_in?
      "Respond to tweet"
    end
  end

  def respond_url(tweet)
    if signed_in?
      Rails.application.routes.url_helpers.new_tweet_response_path(tweet)
    end
  end

  def button_class
    if signed_in?
      "iframe btn btn-primary cboxElement"
    end
  end
end
