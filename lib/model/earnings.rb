class Earnings
  attr_accessor :earnings, :dateToday
 
  def initialize(day)
        @earnings = Hash.new
        @dateToday = day
  end
  
  def put(earning,date)
    @earnings[earning]=date
  end
  
  def getKeys
    @earnings.keys
  end
  
  def getKey(key)
    @earnings[key]
  end
  
  def getHash
  @earnings
  end

end