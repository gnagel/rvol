require 'helper'
require "../lib/util"

class TestUtil < Test::Unit::TestCase

  def test_3rdWeek

    value = DateUtil.get3rdWeek("2010-11")
    puts 'got this many days: '
    puts value
  end

  def test_3rdWeekThisMonth
    
    value = DateDateUtil.get3rdWeek("2010-08")
    puts 'got this many days 4: '
    puts value
    assert_equal 4, value
  end

  def test_3rdWeekBefore
  
    value = DateUtil.get3rdWeek("2010-01")
    puts 'got this many days: '
    puts value
  end
  
  def test_FridayFinder
   
    value = DateUtil.fridayFinder(Date.new.year,Date.new.month)
    puts 'got this many days: '
    puts value
    assert_equal 4, value
  end

  def test_daysToExpiry
   
      p 'days this month:'
      puts DateUtil.daysToExpiryThisMonth
  end

  def test_nextMonth
      p 'getting next month:'
      
      date = DateTime.now
      puts DateUtil.nextMonth(date)

  end




end
