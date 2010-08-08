require 'logger'
class Chain
  attr_accessor :type, :ticker, :date, :strike, :symbol, :last, :chg, :bid, :ask, :vol, :openInt
 
 @@log = Logger.new('./log/error.log','daily') 
 
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
  


end