require 'helper'
require 'test/unit'
class Test_StockScraper < Test::Unit::TestCase

  def test_Stock_Scraper
   tick = StockScraper.downloadStockPrice('GOOG')
   p tick
   assert_not_nil tick
  end
  
end
