require 'logger'
require "./lib/ivolatility"
require "./lib/downloadUtilities"

class Chain
  attr_accessor :type, :ticker, :date, :strike, :symbol, :last, :chg, :bid, :ask, :vol, :openInt, :ivolatility
 

  def initialize(type,ticker, date,strike, symbol, last,chg,bid,ask,vol,openInt)
    @type=type
    @ticker=ticker
    @date=date
    @strike=strike
    @symbol=symbol
    @last=last
    @chg=chg
    @bid=bid
    @ask=ask
    @vol=vol
    @openInt=openInt
  end
  
  def toString
    puts self.inspect
  end
  
  
  
  private 
  def calculate
    
    lastPrice = downloadStockPrice(@ticker)
    strike = @strike
    # calculate date from month 2010-07 into date then get days to expiry
    # how to calculate 3rd friday of month??
    #loop Month days until got the 3rd friday then store store that value
    
    exptime = 0.04109
    irate = 0.14 / 100;

    yields = 0

    oprice = @last

    iv = Ivolatility.new

    # call 0 put 1
    puts iv.IV(lastPrice, strike, exptime, irate, yields, 0, oprice)
    
  end
  


end