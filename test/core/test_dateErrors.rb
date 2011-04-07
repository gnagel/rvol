require "test/unit"
require 'core/dateutil'

class MyTest < Test::Unit::TestCase

  # Parse the options expiry month from the opt symbol
  #
  def test_DateUtil_getDateFromOptSymbol
    date = DateUtil.getDateFromOptSymbol("UNG","UNG1110416C00002000")
    puts 'date ' +date.to_s
    assert_not_nil date
  end


end