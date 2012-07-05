require 'resque'

if Rails.env.staging? || Rails.env.production?
  uri = URI.parse ENV['REDISTOGO_URL']
  $resque_redis_config = { host: uri.host, port: uri.port, password: uri.password }
  Resque.redis = Redis.new $resque_redis_config
  Resque.before_fork = Proc.new {
		ActiveRecord::Base.retrieve_connection
		Resque.redis = Redis.new $resque_redis_config }
else
	Resque.redis = "localhost:6379:1"
end

Resque.enqueue(TwitterFeed)