require 'helper'
require 'reports/ivolatilityreport'
require 'model/stockdaily'
#
# Report
#
class Test_ivolatilityreport < Test::Unit::TestCase
  def test_ivolatilityreport
    Stockscouter.new.parseScouterTop10
    Stockscouter.new.parseScouterTop1
    result = Ticker.all()
    Stocks.new.downloadStock2(result.collect{|tic| tic.symbol},true)
    OptionChainsScraper.new.loadChains(result.collect{|tic| tic.symbol},true)
    IvolatilityReport.new.loadStockScouter
  end
end