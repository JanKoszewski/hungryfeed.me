module TweetsHelper
	def tweet_for_mustache(tweet)
    {
      url: tweet_url(tweet),
      twitter_username: tweet.twitter_username,
      content: tweet.content,
      link: tweet.link,
      twitter_user_image: tweet.twitter_user_image,
      created_at: tweet.created_at.try(:strftime, "%B %e, %Y")
    }
  end
end
