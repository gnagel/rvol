require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require "scrapers/stockscraper"
require "model/stock"

# This class wraps up all financial data downloads and stores the information into a database.
# Errors are logged for quality of service
# Author:: Toni Karhu
# Copyright:: Copyright (c) Toni Karhu
# :title:MarketDownloader

class Downloader


# initialize download
def init
   DataMapper::Logger.new($stdout, :debug)
   # A Sqlite3 connection to a persistent database
   DataMapper.setup(:default, 'sqlite://data/markettoday.db')
   DataMapper::Model.raise_on_save_failure = false
   # checks properties
   DataMapper.finalize
   DataMapper.auto_migrate!
   #DataMapper.auto_upgrade!
   
   self.downloadSP500Tickers
   self.downloadSP500stock
   self.downloadSP500Chains
   #self.createIndexEtfs
   self.downloadEarnings

end  

# This will download all S&P 500 data from the internet and
# store it in a database. Failed reads should be logged for
# later processing
def downloadSP500Tickers
 puts 'starting downloadSP500Tickers'
 result = StockScraper.downloadSP500
 result.each{|ticker|
   begin
   tick = Ticker.new
   tick.created_at = Time.now
   tick.symbol     = ticker
   tick.index      = 'SP500'
   tick.save
   rescue
     puts 'error' + ticker
   end 
 }
end


# This will download all S&P 500 data from the internet and
# store it in a database. Failed reads should be logged for
# later processing
#
def downloadSP500stock
  puts 'starting downloadSP500Stock'
  result = Ticker.all(:index => 'SP500')
  puts result.size
  sp = StockScraper.downloadStock(result.collect{|tic| tic.symbol})
end

# This will download all chains for the S&P500 
# Names taken from last download
# Chains should be loaded for the next 2 months
def downloadSP500Chains
 puts 'starting downloadSP500chains'
 result = Ticker.all()
 OptionChainsScraper.loadChains(result.collect{|tic| tic.symbol})
end

## 
# This will download all earnings for the next month
##
def downloadEarnings
 result = Ticker.all(:index => 'SP500')
 earningsmonth = EarningsScraper.getEarningsMonth2(result.collect{|tic| tic.symbol})
 earningsmonth.each{ |x| x.save }
end

# Download index data and chains
# SPY, DIA, IWM, USO , GLD ,QQQQ, 
# Also download volaitlity: VIX , VXX , VXZ
#
def createIndexEtfs
   indexes = ['SPY','DIA','QQQ','IWM','RUT','RUI','MNX','NDX','MDY','DJX','XLF']
   oil = ['OIH','USO']
   gold = ['GLD','UGL','GDX']
   volatility=['VIX','VXX','VXZ']
   emergingMarkets=['BRF','EEM']
   currencies=['UUP']
   bonds = ['TIP','CLY']
   etfs = [indexes,oil,gold,volatility,emergingMarkets,currencies,bonds]
   etfs.flatten!
   etfs.each{|x| 
     tick = Ticker.new
     tick.created_at = Time.now
     tick.symbol     = x
     tick.index      = 'index-etf'
     tick.save
   }
   
end


#
# Download economic events: Downloads goverment events which will
# have an effect on the markets
#
def downloadEvents
# tbd
end

def printErrors(object)
  object.errors.each do |e|
    puts e
  end
end
  
end