class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext']
        auth_token = message['ext']['auth_token']
      else
        auth_token = message['data']['auth_token']
      end
      if auth_token != FAYE_TOKEN
        message['error'] = 'Invalid authentication token.'
      end
    end
    callback.call(message)
  end
end
