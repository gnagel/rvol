$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'Rvol'
require 'test/unit'
require 'dm-core'
require 'dm-migrations'
require 'model/stock'
require 'model/chain'
require 'model/earning'

#set the test db an in memory db
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default,Rvol.config['test'])
DataMapper.finalize
DataMapper.auto_migrate!
