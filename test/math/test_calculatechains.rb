require "test/unit"
require 'math/calculatechains'
require 'helper'
class MyTest < Test::Unit::TestCase
  def test_chaincalculator
    CalculateChains.new.calculateFrontAndBackMonthsMeanIVITM
    Ticker.all.each{|tick|
      puts tick.frontMonth
      puts tick.backMonth
      #assert_not_nil(tick.frontMonth);
      #assert_not_nil(tick.backMonth);
    }
  end
end