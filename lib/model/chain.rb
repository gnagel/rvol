require 'logger'
require 'math/ivolatility'
require 'scrapers/stockscraper'
require 'core/util'

#
# Holds a single chain for an options
#
class Chain
  include DataMapper::Resource

  @@cache = Hash.new

  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime, :required => true # A DateTime, for any date you might like.
  property :type,                        String, :required => true
  property :ticker,                      String, :required => true
  property :date,                        Date,   :required => true
  property :strike,                      String, :required => true
  property :symbol,                      String, :required => true
  property :last,                        String, :required => true
  property :chg,                         Float,  :required => true
  property :bid,                         String, :required => true
  property :ask,                         String, :required => true
  property :vol,                         Integer,:required => true
  property :openInt,                     Integer,:required => true
  property :ivolatility,                 Float,  :required => true
  
  def initialize(type,ticker, date,strike, symbol, last,chg,bid,ask,vol,openInt)
    self.created_at = Time.now
    self.type=type
    self.ticker=ticker
    self.date=date
    self.strike=strike
    self.symbol=symbol
    self.last=last
    self.chg=Util.toFloat(chg)
    self.bid=bid
    self.ask=ask
    self.vol= Util.removeComma(vol)
    self.openInt = Util.removeComma(openInt)
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
      # get cache if not there get from db if not there get from web
      stock = @@cache[self.ticker] ||= StockDaily.first(:symbol=>self.ticker)
      stock = @@cache[self.ticker] ||= StockScraper.new.downloadStock2([self.ticker],false)[0]
      ivol = iv.IV(stock.price.to_f, self.strike.to_f, expTimeYear.to_f, irate.to_f, yields.to_f, callOrPut, oprice.to_f)
      self.ivolatility = ivol.to_f
    rescue Exception => boom
      puts 'ivolatility calculation failed '
      puts boom
    end
  end

end