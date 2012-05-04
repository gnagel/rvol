# encoding: utf-8
require 'helper'
require 'test/unit'
require 'scrapers/earningsparser'
class Test_Earningsparser< Test::Unit::TestCase



  def test_earningsParser

    EarningsScraper.new.getEarningsMonth2(true)
  end
end