require 'sinatra'
require 'haml'
#
# main class for server.
#
class Server
  get '/' do
    haml :index
  end
end