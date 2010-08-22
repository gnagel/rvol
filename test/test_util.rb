require 'helper'
require "../lib/util"

class TestUtil < Test::Unit::TestCase

  def test_3rdWeek

    value = Util.get3rdWeek("2010-11")
    puts 'got this many days: '
    puts value
  end

  def test_3rdWeekThisMonth
    
    value = Util.get3rdWeek("2010-08")
    puts 'got this many days 4: '
    puts value
    assert_equal 4, value
  end

  def test_3rdWeekBefore
  
    value = Util.get3rdWeek("2010-01")
    puts 'got this many days: '
    puts value
  end
  
  def test_FridayFinder
   
    value = Util.fridayFinder(Date.new.year,Date.new.month)
    puts 'got this many days: '
    puts value
    assert_equal 4, value
  end

  def test_daysToExpiry
   
      p 'days this month:'
      puts Util.daysToExpiryThisMonth
  end

  def test_nextMonth
      p 'getting next month:'
      
      date = DateTime.now
      puts Util.nextMonth(date)

  end




end
