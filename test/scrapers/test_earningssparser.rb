# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'test/unit'
require 'scrapers/earningsparser'
class Test_Earningsparser< Test::Unit::TestCase
  def test_earningsParser
    EarningsScraper.new.getEarningsMonth2
  end
end