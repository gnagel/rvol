require 'scrapers/earningsscraper'
require 'test/unit'
class Test_Earnings_Scraper < Test::Unit::TestCase

  def test_chainsscraper
    OptionChainsScraper.loadChains('GOOG')
  end
end

