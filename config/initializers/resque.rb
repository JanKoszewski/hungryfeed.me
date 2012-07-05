require 'resque'

if Rails.env.staging? || Rails.env.production?
  uri = URI.parse ENV['REDISTOGO_URL']
  REDIS = Resque.redis = Redis.new :host => uri.host, :port => uri.port, :password => uri.password
else
	Resque.redis = "localhost:6379:1"
end

Resque.enqueue(TwitterFeed)