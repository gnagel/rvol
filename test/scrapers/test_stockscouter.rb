# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'test/unit'
require 'model/stock'
require 'scrapers/stocks'
require 'scrapers/stockscouter'

class Test_stockscouter < Test::Unit::TestCase
  def test_parseStockScouter10
    Stockscouter.new.parseScouterTop10
    puts 'done loading 100 rated 10'
  end
  def test_parseStockScouter1
    Stockscouter.new.parseScouterTop1
    puts 'done loading 100 rated 1'
  end
end