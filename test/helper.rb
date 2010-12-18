$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'test/unit'
require 'dm-core'
require 'dm-migrations'
require 'model/stock'
require 'model/chain'
require 'model/earning'
begin
 puts '** INITIALISING TEST DATABASE **'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rvol/data/test_markettoday.db')
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize
DataMapper.auto_migrate!
end
