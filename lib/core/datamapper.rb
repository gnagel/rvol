require 'rubygems'
require 'dm-core'

# A Sqlite3 connection to a persistent database
DataMapper.setup(:default, 'sqlite://data/markettoday.db')