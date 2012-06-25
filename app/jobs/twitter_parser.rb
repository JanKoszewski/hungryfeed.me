class TwitterParser
  TWEET_REGEX = /((?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?)+( via @LivingSocial)/

  def self.perform(tweet_array, data = [])
    tweet_array.each do |tweet|
      if link = find_link(tweet)
        data << link
      end
    end
    data
  end

  def self.find_link(tweet)
    if data = tweet["text"].match(TWEET_REGEX)
      data[1]
    end
  end

  def self.find_user(tweet)
    tweet["from_user"]
  end
end