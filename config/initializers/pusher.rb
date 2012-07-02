require 'pusher'

if Rails.env.production?
	Pusher.app_id = ENV['PUSHER_API_ID']
	Pusher.key = ENV['PUSHER_KEY']
	Pusher.secret = ENV['PUSHER_SECRET']
else
  Pusher.app_id = '23209'
	Pusher.key = 'aafb6670cc00ac6045f1'
	Pusher.secret = 'ead482bb68913f6c4ac6'
end

