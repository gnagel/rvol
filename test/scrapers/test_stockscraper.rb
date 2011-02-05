# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'test/unit'
require 'model/stock'
require 'scrapers/stockscraper'

class Test_StockScraper < Test::Unit::TestCase
  def test_Stock_Scraper
    begin
      ticks = StockScraper.new.downloadStock2(['GOOG','IBM','AAPL'],true)
    rescue => boom
      puts boom
      flunk("TEST FAILED")
    end
  end
  def test_Stock_Scraper_Single
    begin
      ticks = StockScraper.new.downloadStock2(['GOOG'],true)
    rescue => boom
      puts boom
      flunk("TEST FAILED")
    end
  end

end
