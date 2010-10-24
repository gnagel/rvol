require 'helper'
require "model/stock"

class Test_Stock < Test::Unit::TestCase

  
  def test_stock
  
  stock = Stock.new

  stock.symbol = 'AAPL'
  stock.send('symbol' + '=' , 'GOOG')
  #stock.instance_variable_set('symbol','GOOG')
  
  puts stock.symbol
  puts stock.symbol
  
  #stock.methods.each{|m| p m}
  # Get protected instance methods
  #stock.protected_methods.each{|m| puts m}
  # Get private instance methods
  #stock.private_methods.each{|m| puts m}

  end
  
end