# encoding: utf-8
require 'rubygems'
require  'helper'
require 'scrapers/historicalscraper'
require 'test/unit'
require 'model/stock'

class Test_historicalscraper < Test::Unit::TestCase
   def test_historicalData
     stocks = Array.new
     ticker = Ticker.new
     ticker.symbol = 'IBM'
     ticker2 = Ticker.new
     ticker2.symbol = 'LVS'
     stocks << ticker
     stocks << ticker2
     Historicalscraper.new.downloadHistoricalData(stocks,false)
     Historicalscraper.new.downloadHistoricalData(stocks,true)
     puts '*************************************************************'
     puts 'running 2 times to test that only dates not stored are saved'
     puts '*************************************************************'
     Historicalscraper.new.downloadHistoricalData(stocks,true)
   end
end