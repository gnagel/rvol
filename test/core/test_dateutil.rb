require 'helper'
require "core/dateutil"

class TestDateUtil < Test::Unit::TestCase

  def test_3rdWeek

    value = DateUtil.getThirdWeek("2010-11")
    puts value
  end

  def test_3rdWeekThisMonth
    
    value = DateUtil.getThirdWeek("2010-09")
    p 'this month'
    puts value
  end

  def test_3rdWeekBefore
  
    value = DateUtil.getThirdWeek("2010-01")
    puts value
  end
  
  def test_FridayFinder
   
    value = DateUtil.fridayFinder(Date.new.year,Date.new.month)
    puts value
  
  end

  def test_daysToExpiry
   
      p 'days this month:'
  end

  def test_nextMonth
      p 'getting next month:'
      
      date = DateTime.now

  end




end
