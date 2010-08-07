class Chain
  attr_accessor :strike, :symbol, :last, :chg, :bid, :ask, :vol, :openInt
 
  def initialize(strike, symbol, last,chg,bid,ask,vol,openInt)
    @strike=strike
    @symbol=symbol
    @last=last
    @chg=chg
    @bid=bid
    @ask=ask
    @vol=vol
    @openInt=openInt
  end

end