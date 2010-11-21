require 'rubygems'
require 'dm-core'
require 'dm-migrations'
class DataPersistence
  
begin
DataMapper::Logger.new($stdout, :debug)  
# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rfinance/data/markettoday.db')

# A Sqlite3 connection to a persistent database
DataMapper::Model.raise_on_save_failure = false
# checks properties
DataMapper.finalize
#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!
end 

end