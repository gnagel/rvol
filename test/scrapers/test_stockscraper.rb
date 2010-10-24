require 'helper'
require 'test/unit'
require 'model/stock'

class Test_StockScraper < Test::Unit::TestCase

  def test_Stock_Scraper
   tick = StockScraper.downloadStockPrice('GOOG')
   p tick
   assert_not_nil tick
  end
  
  def test_Stock_ScraperYQL

    stock = nil
    
    result = StockScraper.downloadStockPriceYQL(['GOOG','AAPL'])
    result.to_a.each { |stock|
       puts stock.symbol   
       puts stock.bid
    }  
      
    #     result.each { |e|
    #      stock = Stock.new  
    #      e['query']['results']['quote'].each{ |key,value|
    #          dkey = key.sub(/\b\w/) { $&.downcase }
    #          stock.send(dkey + '=' , value)
    #         }
    #      puts stock.symbol   
    #      puts stock.bid
    #      
    #    }
     
  end
  
  def test_StockScraper_downloadSP500
    StockScraper.downloadSP500
  end
  
end
