$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'test/unit'
require 'model/stock'
require 'scrapers/stockscraper'

class Test_StockScraper < Test::Unit::TestCase

  def test_Stock_Scraper
   begin 
   ticks = StockScraper.new.downloadStock2(['GOOG','IBM','AAPL'])
   rescue => boom
     puts boom
     flunk("TEST FAILED")
   end
  end
end
      