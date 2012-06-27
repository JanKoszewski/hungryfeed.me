require 'hashie'

class ClientEvent
  MONITORED_CHANNELS = ['/meta/subscribe', '/meta/disconnect', '/meta/unsubscribe']

  def incoming(message, callback)
    return callback.call(message) unless MONITORED_CHANNELS.include? message['channel']

    faye_msg = Hashie::Mash.new(message)
    faye_action = faye_msg.channel.split('/').last

    if client_info = get_client(faye_msg, faye_action)
      faye_client.publish("/rooms/#{client_info[:room_id]}/#{client_info[:branch]}/new", build_hash(client_info, faye_action))
    end
    callback.call(message)
  end

  def build_hash(client_info, action)
    if action == 'subscribe'
      message_hash = { 'content' => "#{client_info[:username]} entered the room.", 'branch' => "#{client_info[:branch]}", 'room_id' => "#{client_info[:room_id]}", 'created_at' => Time.now, 'auth_token' => FAYE_TOKEN, 'connected_users' => "#{connected_users(client_info[:branch])}"}
    elsif action == 'disconnect' || action == 'unsubscribe'
      message_hash = { 'content' => "#{client_info[:username]} left the room.", 'branch' => "#{client_info[:branch]}", 'room_id' => "#{client_info[:room_id]}", 'created_at' => Time.now, 'auth_token' => FAYE_TOKEN, 'connected_users' => "#{connected_users(client_info[:branch])}" }
    end
  end

  def faye_client
    @faye_client ||= Faye::Client.new(FAYE_URL)
  end

  def connected_clients
    @connected_clients ||= { }
  end

  def push_client(msg)
    connected_clients[msg.clientId] = {username: msg.data.github_username, room_id: msg.room_id, branch: msg.branch}
  end

  def pop_client(msg)
    connected_clients.delete(msg.clientId)
  end

  def get_client(msg, action)
    if action == 'subscribe'
      push_client(msg)
    elsif action == 'disconnect' || action == 'unsubscribe'
      pop_client(msg)
    end
  end

  def connected_users(branch)
    connected_clients.collect do |key, value|
      value[:username] if value[:branch] == branch
    end.compact.uniq
  end
end
