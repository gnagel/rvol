# encoding: utf-8
require 'typhoeus'
#
# Connect to the internet and downloads stock info from various sites
#
class Scraper
  #
  # Download stock info  from yahoo
  #
  def self.downLoadYahooCSV(csvTickers)
    request = Typhoeus::Request.new('http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(csvTickers+'&f=sl1a2vnqyd&e=.csv'))
  end
  #
  # Download S&P500 list from wikipedia
  #
  def self.downLoadSP500WikiPedia
   response = Typhoeus::Request.get('http://en.wikipedia.org/wiki/List_of_S%26P_500_companies')
  end
  #
  # Download S&P 500 list from yahoo
  #
  def self.downLoadSP500Yahoo(i)
     request = Typhoeus::Request.new('http://finance.yahoo.com/q/cp?s=%5EGSPC&c='+i.to_s)
  end 
  #
  # Download history for a single ticker for a year.
  #
  def self.downLoadHistory(ticker)
    request = Typhoeus::Request.new('http://www.google.com/finance/historical?q='+ticker+'&output=csv')
  end

  #
  # Single call to get top 50 from stock scouter
  #
  def self.downLoadStockScouterTop50
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=50')
  end
  
  #
  # Single call to get top 50 with rating 10 from stock scouter
  #
  def self.downLoadStockScouterTop1050
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=10')
  end
  #
  # Single call to get top 50-100 with rating 10 from stock scouter
  #
  def self.downLoadStockScouterTop10100
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=10&page=2&col=13')
  end
  
  
  #
  # Single call to get top 50 with rating 1 from stock scouter
  #
  def self.downLoadStockScouterTop150
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=1')
  end  
 
  #
  # Single call to get top 50-100 with rating 1 from stock scouter
  #
  def self.downLoadStockScouterTop1100
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=1&page=2&col=13')
  end
  
  ##
  # Single call only to get list of stockscouter rated 10
  #
  def self.downLoadStockScouter10
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=10')
  end
  
  ##
  # Single call only to get list of etfs with top volume
  #
  def self.down100VolETF
    response = Typhoeus::Request.get('http://finance.yahoo.com/etf/browser/tv?c=0&k=5&f=0&o=d&cs=0&ce=100')
  end
  
end