require 'helper'
require 'core/downloader'

class TestDownloader < Test::Unit::TestCase
  
  def test_downloader
      down = Downloader.new 
      down.init
  end

end