require 'rubygems'
require 'active_record'
require 'Logger'

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.colorize_logging = false

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "data/market.db"
)
class Index < ActiveRecord::Base
 has_many :Stocks
end

class Stock < ActiveRecord::Base
 belongs_to :Index
 has_many :Chains
end

puts 'testing sqllite3'
puts Index.count