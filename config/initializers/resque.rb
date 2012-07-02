require 'resque'

if Rails.env.production?
	ENV["REDISTOGO_URL"] ||= "localhost:6379:1"
	uri = URI.parse(ENV["REDISTOGO_URL"])
	Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
else
	Resque.redis = "localhost:6379:1"
end

Resque.enqueue(TwitterFeed)