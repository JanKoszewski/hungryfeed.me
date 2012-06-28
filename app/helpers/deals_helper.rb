module DealsHelper
	def deal_for_mustache(deal)
    {
      url: deal.link,
      purchased: deal.purchased,
      image: deal.image,
      title: deal.title
    }
  end
end
