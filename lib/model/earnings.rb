class Earnings
  attr_accessor :earnings, :dateToday
  
  def initialize(day)
        @earnings = Hash.new
        @dateToday = day
  end
  
  def put(earning,date)
    earningO = Earning.new(date,earning)
    @earnings[earningO]=date
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

class Earning
  attr_accessor :chains, :date, :ticker, :frontMonth, :backMonth
  
  def initialize(day,ticker)
        @date = day
        @ticker = ticker
        @chains = Hash.new
  end
  
  def addChains(date,chains)
    @chains[date]=chains
  end
  
 
  
  def loadVolatilityForBackMonth
    # load next month
    
  end


end