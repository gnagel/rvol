require 'logger'
require "core/DateUtil"
require "math/ivolatility"
require "scrapers/stockscraper"


class Chain < ActiveRecord::Base
  belongs_to :Stock
  attr_accessor :type, :ticker, :date, :strike, :symbol, :last, :chg, :bid, :ask, :vol, :openInt,:lastPrice,
  :ivolatility, :expTime, :expTimeYear, :irate, :yields
 

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
    #self.calculateIVol
  end
  
  def toString
    puts self.inspect
  end
  

  
  def calculateIVol
   
    @lastPrice = StockScraper.downloadStockPrice(@ticker)
    strike = @strike
    iv = Ivolatility.new

    @expTime =  DateUtil.getDaysToExpFriday(@date)
   
    @expTimeYear = iv.expireTime(@expTime)
 
    # constantdate
    @irate = 0.14 / 100;

    @yields = 0

    oprice = @last

   
    # call 0 put 1
    @type=='C'?callOrPut=0:callOrPut=1
    ivol = iv.IV(@lastPrice.to_f, strike.to_f, @expTimeYear.to_f, @irate.to_f, @yields.to_f, callOrPut, oprice.to_f)
    @ivolatility = 0
    if(ivol<1000.00&&ivol>0)
    @ivolatility = ivol
    end
 
  end
  


end