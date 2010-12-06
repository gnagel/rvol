$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'scrapers/optionschainsscraper'
require 'test/unit'

class Test_Options_Scraper < Test::Unit::TestCase

  def test_chainsscraper
    a = Array.new
    a[0]="GOOG"
    OptionChainsScraper.new.loadChains(['NOK'],false)
  end
end

