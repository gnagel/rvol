$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/chain"

class TestChain < Test::Unit::TestCase
  def test_chain

    c = Chain.new('C','GOOG', '2010-11-01T00:00:00+00:00',490.to_f, "CNX101120P00035000", 420.to_f,0.to_f,410.to_f,
    430.to_f,0.to_f,0.to_f)

  end

end
