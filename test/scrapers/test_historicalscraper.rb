# encoding: utf-8
require 'helper'
require 'scrapers/historicalscraper'
require 'test/unit'
class Test_historicalscraper < Test::Unit::TestCase
   def test_historicalData
     Historicalscraper.downloadHistoricalData(['IBM','IWM'],false)
   end
end