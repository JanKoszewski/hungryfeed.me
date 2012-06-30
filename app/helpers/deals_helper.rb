module DealsHelper
	def deal_for_mustache(deal)
    {
      id: deal.id,
      url: deal.link,
      purchased: deal.purchased,
      image: deal.image,
      title: deal.title,
      tweets: tweets_for_deal(deal)
    }
  end

  def tweets_for_deal(deal)
  	deal.tweets.each do |tweet|
  		tweet_for_mustache(tweet)
  	end
  end
end
