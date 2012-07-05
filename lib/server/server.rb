require 'sinatra'
require 'haml'
#
# main class for server.
#
class Server
  get '/' do
    haml :indexName
  end
end