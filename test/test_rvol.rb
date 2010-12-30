require 'helper'
require 'Rvol'

class TestRvol < Test::Unit::TestCase 
  include Rvol 
  def test_length
    s = "Hello, World!"
    assert_equal(13, s.length)
  end
  def test_config
    begin
      puts Rvol.config
    rescue => e
      flunk("config fucked")
    end
  end
end
