require 'helper'
require 'store'
require 'model/chain'

class TestStore < Test::Unit::TestCase
  
  

  
  def test_Store_save
    c = Chain.new('C','GOOG', '2010-08',490.to_f, 'AAAH', 420.to_f,3.to_f,410.to_f,
        430.to_f,3.to_f,2.to_f)
    p 'storing'
    Store.saveObject('test_key',c)
    p 'done'
    p Store.listContents
    c = Store.get('test_key')
    c.toString
  end
  
  def test_Store_load
    p 'loading'
    c = Store.get('test_key')
    c.toString
    
  end
  
  
  
end