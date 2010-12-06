$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require 'math/arraymath'

class TestArrayMath  < Test::Unit::TestCase
 
 def test_array_closest
  array = [1,3,8,10,13]
  int = array.closest 11
  assert_equal(int,10)
 end
 
end