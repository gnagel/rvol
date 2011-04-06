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
    tick = Ticker.all(:symbol=>'IBM')
    puts 'debug'
    puts tick[0].symbol
    puts tick[0].frontMonth
    puts tick[0].backMonth
  end

  def createTestTickers
    Ticker.create(:symbol=>'IBM',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'IWM',:created_at=>Time.now,:index=>'testdata')
    Ticker.create(:symbol=>'AAPL',:created_at=>Time.now,:index=>'testdata')

  end
end