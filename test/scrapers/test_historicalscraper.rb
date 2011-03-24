# encoding: utf-8
require 'helper'
require 'scrapers/historicalscraper'
require 'test/unit'
class Test_historicalscraper < Test::Unit::TestCase
   def test_historicalData
     stocks = Array.new
     ticker = Ticker.new
     ticker.symbol = 'IBM'
     ticker2 = Ticker.new
     ticker2.symbol = 'IWM'
     stocks << ticker
     stocks << ticker2
     Historicalscraper.new.downloadHistoricalData(stocks,false)
     Historicalscraper.new.downloadHistoricalData(stocks,true)
   end
end