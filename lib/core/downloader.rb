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
   DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rfinance/data/markettoday.db')
   DataMapper::Model.raise_on_save_failure = true 
   # checks properties
   DataMapper.finalize
   DataMapper.auto_migrate!
   #DataMapper.auto_upgrade!
   
   self.downloadSP500Tickers
   self.downloadSP500Chains
   self.downloadEarnings
end  

# This will download all S&P 500 data from the internet and
# store it in a database. Failed reads should be logged for
# later processing
def downloadSP500Tickers
 result = StockScraper.downloadSP500
 result.each{|ticker|
   begin
   tick = Ticker.new
   tick.created_at = Time.now
   tick.symbol     = ticker
   tick.index      = 'SP500'
   tick.save
   rescue
     #puts 'unique' + ticker
   end 
 }
 
end


# This will download all chains for the S&P500 
# Names taken from last download
# Chains should be loaded for the next 2 months
def downloadSP500Chains
 result = Ticker.all(:index => 'SP500')
 chains = OptionChainsScraper.loadChains(result.collect{|tic| tic.symbol})
 chains.each {|x| x.save }
end

# This will download all earnings for the next month
#
#
def downloadEarnings
 earningsmonth = EarningsScraper.getEarningsMonth2
 earningsmonth.each{ |x| x.save }
end

# Download index data and chains
# SPY, DIA, IWM, USO , GLD ,QQQQ, 
# Also download volaitlity: VIX , VXX , VXZ
#
def downloadIndexData
   
end

# This will download all S&P 500 data from the internet and
# store it in a database. Failed reads should be logged for
# later processing
#
def downloadSP500stock
  result = Ticker.all(:index => 'SP500')
  sp = StockScraper.downloadStockPriceYQL('GOOG')
  sp.each {|x|
      if x.save
         # is valid and has been saved
       else
         puts 'fuck'
        x.errors.each do |e|
           puts e
         end
       end
  }
end

end