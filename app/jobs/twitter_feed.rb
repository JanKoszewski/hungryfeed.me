require 'faraday'

class TwitterFeed
  def self.perform
    @conn = Faraday.new(:url => "http://search.twitter.com/search.json")

    resp = @conn.get do |req|
      req.params["q"]="@livingsocial"
      req.headers['Content-Type']='application/json'
    end

    response = JSON.parse(resp.body)
    response["results"]
  end
end