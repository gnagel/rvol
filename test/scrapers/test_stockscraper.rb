require 'helper'
require 'test/unit'
require 'model/stock'

class Test_StockScraper < Test::Unit::TestCase

  def test_Stock_Scraper
   ticks = StockScraper.downloadStockPrice(['GOOG','IBM'])
   ticks.each{|tick|
    p tick.price
   }
        assert_not_nil ticks
  end
      
        
  def test_StockScraper_downloadSP500
          StockScraper.downloadSP500
  end
        
end
      