require 'faye'
load 'faye/server_auth.rb'
require File.expand_path('../config/initializers/faye.rb', __FILE__)
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.add_extension(ServerAuth.new)
Faye::WebSocket.load_adapter('thin')
run faye_server