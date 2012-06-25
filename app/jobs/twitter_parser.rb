class TwitterParser
  TWEET_REGEX = /((?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?)+( via @LivingSocial)/

  def self.perform(tweet_array)
    tweet_array.each do |tweet|
      if find_link(tweet)
        create_tweet_from(tweet)
      end
    end
  end

  def self.find_link(tweet)
    if data = tweet["text"].match(TWEET_REGEX)
      data[1]
    end
  end

  def self.create_tweet_from(tweet)
    Tweet.create(:content => tweet["text"], 
                 :twitter_username => tweet["from_user"], 
                 :twitter_user_image => tweet["profile_image_url_https"]
                 )
  end

  def self.create_deal_from(link)
    Deal.new
  end
end