require 'helper'
require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require "model/stock"

 begin
    DataMapper::Logger.new($stdout, :debug)
 DataMapper.setup(:default, 'sqlite://data/markettoday.db')   
 p 'loading'
 sd = StockDaily.get(1)
  sd2 = StockDaily.first(:symbol=>'BLL')
 puts sd2.price 
 end