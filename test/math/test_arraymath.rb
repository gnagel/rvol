require 'helper'
require 'math/arraymath'

class TestArrayMath  < Test::Unit::TestCase
 
 def test_array_closest
  array = [1,3,8,10,13]
  puts array.closest 11
 end
 
end