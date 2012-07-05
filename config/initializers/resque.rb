require 'resque'

if Rails.env.staging? || Rails.env.production?
  uri = URI.parse ENV['REDISTOGO_URL']
  Resque.redis = Redis.new :host => uri.host, :port => uri.port, :password => uri.password
  Resque.after_fork = Proc.new { ActiveRecord::Base.retrieve_connection}
else
	Resque.redis = "localhost:6379:1"
end

Resque.enqueue(TwitterFeed)