require 'logger'
require "core/DateUtil"
require "math/ivolatility"
require "scrapers/stockscraper"


class Chain 
  include DataMapper::Resource

  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  # A DateTime, for any date you might like.
  property :type,                        String
  property :ticker,                      String
  property :date,                        DateTime
  property :strike,                      String
  property :symbol,                      String
  property :last,                        String
  property :chg,                         String
  property :bid,                         String
  property :ask,                         String
  property :vol,                         String    
  property :openInt,                     String
  property :ivolatility,                 String    

  def initialize(type,ticker, date,strike, symbol, last,chg,bid,ask,vol,openInt)
    self.created_at = Time.now
    self.type=type
    self.ticker=ticker
    self.date=date
    self.strike=strike
    self.symbol=symbol
    self.last=last
    self.chg=chg
    self.bid=bid
    self.ask=ask
    self.vol=vol
    self.openInt=openInt
    self.calculateIVol
  end
  
  def toString
    puts self.inspect
  end
  

  # calcualtes the implied volatility for the chain
  
  def calculateIVol
    begin
    
    lastPrice = StockDaily.first(:symbol=>self.ticker)
    strike = self.strike
    iv = Ivolatility.new
    expTime =  DateUtil.getDaysToExpFriday(self.date)
    
    expTimeYear = iv.expireTime(expTime)
    # constantdate
    irate = 0.14 / 100;
    yields = 0
    oprice = self.last
    # call 0 put 1
    type=='C'?callOrPut=0:callOrPut=1

    ivol = iv.IV(lastPrice.price.to_f, self.strike.to_f, expTimeYear.to_f, irate.to_f, yields.to_f, callOrPut, oprice.to_f)
    
    self.ivolatility = ivol.to_f

    rescue Exception => boom
      puts 'ivolatility calculation failed ' + boom
    end
 
  end
  


end