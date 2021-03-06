require 'nokogiri'
require 'open-uri'
require 'mechanize'

class TwitterParser
  @queue = :twitter_parser
  TWEET_REGEX = /((?:http|https):\/\/[a-z0-9]+(?:[\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(?:(?::[0-9]{1,5})?\/[^\s]*)?)/
  LINK_VALIDATION_REGEX = /www.livingsocial.com\/(\w+)/

  def self.perform(tweet_array)
    tweet_array.each do |tweet|
      if link = find_link(tweet)
        if validate_link(link)
          deal_id = create_deal_from(link).id
          create_tweet_from(tweet, deal_id)
        end
      end
    end
  end

  def self.find_link(tweet)
    agent = Mechanize.new
    if data = tweet["text"].match(TWEET_REGEX)
      begin
        agent.get(data[1]).uri.to_s
      rescue Exception
        false
      end
    end
  end

  def self.create_tweet_from(original_tweet, deal_id)
    tweet = Tweet.where(:content => original_tweet["text"], :twitter_username => original_tweet["from_user"]).first_or_initialize
    tweet.twitter_user_image = original_tweet["profile_image_url_https"]
    tweet.link = "https://twitter.com/#{original_tweet["from_user"]}/status/#{original_tweet["id_str"]}"
    tweet.deal_id = deal_id
    tweet.save
    tweet
  end

  def self.create_deal_from(link)
    deal_page = parse_deal_page(link)
    deal = Deal.where(:link => deal_page[:link]).first_or_initialize
    deal.title = deal_page[:title]
    deal.image = deal_page[:image]
    deal.purchased = deal_page[:purchased]
    deal.save
    deal
  end

  def self.parse_deal_page(link)
    doc = build_doc(link)
    {:link => doc.at('link[rel=canonical]')['href'], 
     :image => doc.at('//img')['src'], 
     :purchased => doc.at('.purchased .value').text.gsub(/\D/, "").to_i,
     :title => doc.at('.deal-title h1').text
    }
  end

  def self.build_doc(link)
    doc = Nokogiri::HTML(open(link))
  end 

  def self.validate_link(link)
    if link.match(LINK_VALIDATION_REGEX) && link.match(LINK_VALIDATION_REGEX)[1] != "events"
      true
    end
  end
end