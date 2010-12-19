$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'scrapers/optionschainsscraper'
require 'test/unit'

class Test_Options_Scraper < Test::Unit::TestCase

  def test_chainsscraper
    chains = OptionChainsScraper.new.loadChains(['NOK','GOOG'],true)
    puts chains.size
    
  end
end

