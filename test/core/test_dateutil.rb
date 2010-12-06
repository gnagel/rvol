$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'core/dateutil'
require 'date'

class TestDateUtil < Test::Unit::TestCase

  #
  # Hard to test as dates change and we use current dates in calculations
  #
  def test_3rdWeek
    
    date = DateTime.now
    value = DateUtil.getDaysToExpFriday(date)
   
    puts "DateUtil.getDaysToExpFriday(date)  " +date.to_s
    puts value
    assert_not_nil value
    
    date2 = date >> 1
    puts "DateUtil.getDaysToExpFriday(date2)  " +date2.to_s
    value = DateUtil.getDaysToExpFriday(date2)
    assert_not_nil value
    puts value
  end
  
  def test_expiry_date
  days = DateUtil.fridayFinder(DateTime.now.year,DateTime.now.month)
  assert_not_nil days
  puts '3rd friday date:'
  puts days
  end
  #
  # Generate the option symbol from the date for  the front month. If the date is past expiry give next month
  #
  def test_DateUtil_getOptSymbThisMonth
   symb = DateUtil.getOptSymbThisMonth("GOOG")
   puts 'symbol this month: '+symb
   assert_not_nil symb
  end
  
  #
  # Generate the option symbol from the date for  the front month. If the date is past expiry give next month
  #
  def test_DateUtil_getOptSymbThisMonth
   symb = DateUtil.getOptSymbThisMonth("GOOG")
   puts 'symbol this month: '+symb
   assert_not_nil symb
  end

  #
  # Generate the option symbol from the date for the back month. If the date is past expiry give next month
  #
  def test_DateUtil_getOptSymbNextMonth
    symb = DateUtil.getOptSymbNextMonth("GOOG")
    puts 'symbol next month: '+symb
    assert_not_nil symb
  end

  #
  # Parse the options expiry month from the opt symbol
  #
  def test_DateUtil_getDateFromOptSymbol
    date = DateUtil.getDateFromOptSymbol("ADBE","ADBE101016C00035000")
    puts 'date ' +date.to_s
    assert_not_nil date
  end


end
