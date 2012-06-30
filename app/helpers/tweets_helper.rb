module TweetsHelper
	def tweet_for_mustache(tweet)
    {
      id: tweet.id,
      deal_id: tweet.deal.id,
      url: tweet.link,
      twitter_username: tweet.twitter_username,
      content: tweet.content,
      twitter_user_image: tweet.twitter_user_image,
      klout_score: tweet.user.klout_score
    }
  end
end
