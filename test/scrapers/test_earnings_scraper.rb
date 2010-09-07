require 'scrapers/earningsscraper'
require 'test/unit'
class Test_Earnings_Scraper < Test::Unit::TestCase

  def test_earningsscraper
    EarningsScraper.getEarningsMonth2
  end
end