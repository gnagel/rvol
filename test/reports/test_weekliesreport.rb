require 'helper'
require "test/unit"
require 'reports/weekliesreport'
require 'math/calculatestd'
require 'scrapers/historicalscraper'
class Test_weekliesreport < Test::Unit::TestCase

  @@once = false

  def setup
    if (!@@once)
      ticker = ['AAPL', 'LVS','NOK']
      chains = OptionChainsScraper.new.loadChains(ticker, true)
       stocks = Stocks.new.downloadStock2(ticker,true)
       Historicalscraper.new.downloadHistoricalData(stocks,true)
       CalculateStd.new.calculateStd
    end
    @@once = true
  end


  def test_weekliesload

    Weekliesreport.new.generateReport
  end
end