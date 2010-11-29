require 'scrapers/earningsscraper'
require 'test/unit'
class Test_Earnings_Scraper < Test::Unit::TestCase

  def test_chainsscraper
    a = Array.new
    a[0]="GOOG"
    OptionChainsScraper.new.loadChains(['GOOG','AAPL'],false)
  end
end

