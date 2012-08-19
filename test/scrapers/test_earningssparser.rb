# encoding: utf-8
require 'helper'
require 'test/unit'
require 'scrapers/earningsparser'
class Test_Earningsparser< Test::Unit::TestCase

  def test_earningsParser
    puts '***** testing EARNINGS!!!!!'
    EarningsScraper.new.getEarningsMonth2(true)
    Earning.all.each{|earn|
    puts '***** test'
     puts earn.ticker
    }
  end
end