require "test/unit"
require 'math/calculatechains'
require 'helper'
class MyTest < Test::Unit::TestCase
  # Fake test
  def test_chaincalculator

    tick = Ticker.all(:symbol=>'IBM')
    puts 'debug'
    puts tick[0].symbol
    puts tick[0].frontMonth
    puts tick[0].backMonth
    assert_not_nil(tick[0].frontMonth)
    assert_not_nil(tick[0].backMonth)
  end


end