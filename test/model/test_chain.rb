require 'helper'
require "model/chain"



class TestChain < Test::Unit::TestCase

  
  def test_chain
  
    c = Chain.new('C','GOOG', '2010-08',490.to_f, 'AAAH', 420.to_f,0.to_f,410.to_f,
      430.to_f,0.to_f,0.to_f)
  
  end

  # todo
  def test_chain2

    c = Chain.new('P','GOOG', '2010-12',490.to_f, 'AAAH', 420.to_f,0.to_f,410.to_f,
      430.to_f,0.to_f,0.to_f)

  end
  
  
  
end
