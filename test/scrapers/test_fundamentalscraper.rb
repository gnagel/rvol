# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'test/unit'
require "scrapers/fundamentalscraper"
class Test_fundamentalscraper< Test::Unit::TestCase
    def test_parseCaps
      income5 = Fundamentalscraper.new.parseIncomeStatement('nok','ann')
      assert_not_nil income5
      assert_not_nil income5.NetIncome
      puts 'net income'
      puts income5.NetIncome
      puts 'EPS: '
      puts income5.BasicNormalizedEPS

      income5 = Fundamentalscraper.new.parseIncomeStatement('nok','qtr')
      assert_not_nil income5
      assert_not_nil income5.NetIncome
      puts 'net income'
      puts income5.NetIncome
      puts 'EPS: '
      puts income5.BasicNormalizedEPS

      income5 = Fundamentalscraper.new.parseIncomeStatement('AAPL')
      assert_not_nil income5
      assert_not_nil income5.NetIncome
      puts 'net income'
      puts income5.NetIncome
      puts 'EPS: '
      puts income5.BasicNormalizedEPS
    end
end