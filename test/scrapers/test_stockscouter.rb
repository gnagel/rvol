# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'test/unit'
require 'model/stock'
require 'scrapers/stocks'
require 'scrapers/stockscouter'

class Test_stockscouter < Test::Unit::TestCase
  def test_parseStockScouter10
    begin
    Stockscouter.new.parseScouterTop10
    puts 'done loading 100 rated 10'
     rescue => e
      flunk(e)
    end
  end
  def test_parseStockScouter1
    begin
    Stockscouter.new.parseScouterTop1
    puts 'done loading 100 rated 1'
     rescue => e
      flunk(e)
    end
  end

  def test_parseStockScouter50
    begin
    Stockscouter.new.parseScouterTop50
    puts 'done loading top 50'
    rescue => e
      flunk(e)
    end
  end

end