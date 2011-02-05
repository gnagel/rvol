# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/stock"

class Test_Stock < Test::Unit::TestCase
  def test_stock

    stock = StockDaily.new

    stock.symbol = 'AAPL'
    stock.send('symbol' + '=' , 'GOOG')
    #stock.instance_variable_set('symbol','GOOG')

    puts stock.symbol

    #stock.methods.each{|m| p m}
    # Get protected instance methods
    #stock.protected_methods.each{|m| puts m}
    # Get private instance methods
    #stock.private_methods.each{|m| puts m}

  end

end