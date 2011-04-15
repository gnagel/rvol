require 'helper'
require "test/unit"
require 'reports/weekliesreport'
class Test_weekliesreport < Test::Unit::TestCase

  @@once = false

  def setup
    if (!@@once)
      ticker = ['AAPL', 'LVS','NOK']
      chains = OptionChainsScraper.new.loadChains(ticker, true)
    end
    @@once = true
  end


  def test_weekliesload

    Weekliesreport.new.findAllWeeklies
  end
end