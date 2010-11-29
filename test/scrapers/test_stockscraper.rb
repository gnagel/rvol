require 'helper'
require 'test/unit'
require 'model/stock'

class Test_StockScraper < Test::Unit::TestCase

  def test_Stock_Scraper
   ticks = StockScraper.new.downloadStock2(['GOOG','IBM'])
        #assert_not_nil ticks
  end
end
      