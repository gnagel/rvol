require 'helper'
require "../lib/util"

class TestUtil < Test::Unit::TestCase

  def test_3rdWeek
    util = Util.new
    value = util.get3rdWeek("2010-11")
    puts 'got this many days: '
    puts value
  end



end
