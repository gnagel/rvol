# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'scrapers/rss'
require 'test/unit'

#
#
#
class Test_Options_Scraper < Test::Unit::TestCase
  def test_rssscraper
  RssScraper.new.loadRSS('LVS')
  end
end