require 'logger'
require "core/DateUtil"
require "math/ivolatility"
require "scrapers/stockscraper"

class Chain 
  include DataMapper::Resource
  
  @@cache = Hash.new

  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  , :required => true# A DateTime, for any date you might like.
  property :type,                        String, :required => true
  property :ticker,                      String, :required => true
  property :date,                        Date, :required => true
  property :strike,                      String, :required => true
  property :symbol,                      String, :required => true
  property :last,                        String, :required => true
  property :chg,                         String, :required => true
  property :bid,                         String, :required => true
  property :ask,                         String, :required => true
  property :vol,                         String, :required => true
  property :openInt,                     String, :required => true
  property :ivolatility,                 String, :required => true

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
    self.ivolatility = 0
    self.calculateIVol
  end
  
  def toString
    puts self.inspect
  end
  
  #
  # calcualtes the implied volatility for the chain
  #
  def calculateIVol
    begin

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

    stock = @@cache[self.ticker] ||= StockDaily.first(:symbol=>self.ticker)
    ivol = iv.IV(stock.price.to_f, self.strike.to_f, expTimeYear.to_f, irate.to_f, yields.to_f, callOrPut, oprice.to_f)
    
    self.ivolatility = ivol.to_f

    rescue Exception => boom
      puts 'ivolatility calculation failed '
      puts boom
    end
 
  end
  
end