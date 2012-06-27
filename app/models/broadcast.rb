module Broadcast
	def broadcast(channel, msg)
    message = {:channel => channel, :data => msg, :ext => {:auth_token => FAYE_TOKEN }}
    uri = URI.parse(FAYE_URL)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end