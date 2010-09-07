require 'logger'
require "core/DateUtil"
require "math/ivolatility"
require "scrapers/stockscraper"


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
    calculate
  end
  
  def toString
    puts self.inspect
  end
  
  
  
  private 
  def calculate
   
    lastPrice = StockScraper.downloadStockPrice(@ticker)
    strike = @strike
    iv = Ivolatility.new

    exptime =  DateUtil.getThirdWeek(@date)
   
    exptimeYear = iv.expireTime(exptime)
 
    # constantdate
    irate = 0.14 / 100;

    yields = 0

    oprice = @last


    # call 0 put 1
    @type=='C'?callOrPut=0:callOrPut=1
    @ivolatility = iv.IV(lastPrice.to_f, strike.to_f, exptimeYear.to_f, irate.to_f, yields.to_f, callOrPut, oprice.to_f)
   
  end
  


end