require 'nokogiri'
require 'open-uri'
require 'mechanize'

class TwitterParser
  TWEET_REGEX = /((?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?)+( via @LivingSocial)/
  LINK_VALIDATION_REGEX = /livingsocial.com\/(\w+)/

  def self.perform(tweet_array)
    tweet_array.each do |tweet|
      if link = find_link(tweet)
        if validate_deal_with(link)
          deal_id = create_deal_from(link).id
          create_tweet_from(tweet, deal_id)
        end
      end
    end
  end

  def self.find_link(tweet)
    agent = Mechanize.new
    if data = tweet["text"].match(TWEET_REGEX)
      link = agent.get(data[1]).uri.to_s
    end
  end

  def self.create_tweet_from(tweet, deal_id)
    Tweet.create(:content => tweet["text"], 
                 :twitter_username => tweet["from_user"], 
                 :twitter_user_image => tweet["profile_image_url_https"],
                 :deal_id => deal_id
                 )
  end

  def self.create_deal_from(link)
    doc = Nokogiri::HTML(open(link))
    deal = Deal.where(:link => doc.at('link[rel=canonical]')['href'],
                      :image => doc.at('//img')['src']
                      ).first_or_initialize
    deal.purchased = doc.at('.purchased .value').text.match(/\d/)[0]
    deal.save
    deal
  end

  def self.validate_deal_with(link)
    unless link.match(LINK_VALIDATION_REGEX)[1] == "events"
      true
    end
  end
end