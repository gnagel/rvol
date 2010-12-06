$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'

require "math/ivolatility"

class TestIvolatility < Test::Unit::TestCase
  

   def test_ivolatility
     
      lastPrice = 23.28
      strike = 25
      exptime = 0.04109
      irate = 0.11 / 100;

      yields = 0

      oprice = 4.60

      iv = Ivolatility.new

      # call 0 put 1
      value = iv.IV(lastPrice, strike, exptime, irate, yields, 0, oprice)
      
     # assert_equal(Float(2.81330337796281), Float(value))
      
   end

def test_date
   iv = Ivolatility.new
   time = iv.expireTime(20)
   p 'time'
   p time
end 


 end