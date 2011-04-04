require "test/unit"
require 'math/calculatechains'
require 'helper'
class MyTest < Test::Unit::TestCase
  # Fake test
  def test_chaincalculator
    createTestTickers
    result = Ticker.all
    Stocks.new.downloadStock2(result.collect{|tic| tic.symbol},true)
    OptionChainsScraper.new.loadChains(result.collect{|tic| tic.symbol},true)
    CalculateChains.new.calculateFrontAndBackMonthsMeanIVITM
  end

  def createTestTickers
    Ticker.create(:symbol=>'IBM',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'IWM',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'AAPL',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'GOOG',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'LVS',:created_at=>Time.now,:index=>'testdata')
  end
end