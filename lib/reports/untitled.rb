require '../core/store'
require "../model/earnings"

class Array
  def closest int
    diff = int-self[0]; best = self[0]
    each {|i|
      if (int-i).abs < diff.abs
        best = i; diff = int-i
      end
    }
    best
  end
end
puts [1,3,8,10,13].closest 9

begin
#Store.saveObject("test.earnings.report",@earnings)

earnings = Store.get("test.earnings.report")
puts earnings

end

# find closest call 
# find closest put