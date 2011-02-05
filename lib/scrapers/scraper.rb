require 'typhoeus'

#
#Connect to the internet and downloads pages from various sites
#
class Scraper
  
  def Scraper.downLoadYahooCSV(csvTickers)
    request = Typhoeus::Request.new('http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(csvTickers+'&f=sl1a2vnqyd&e=.csv'))
  end
  
  def Scraper.downLoadSP500WikiPedia
   response = Typhoeus::Request.get('http://en.wikipedia.org/wiki/List_of_S%26P_500_companies')
  end
  
  def Scraper.downLoadSP500Yahoo(i)
     request = Typhoeus::Request.new('http://finance.yahoo.com/q/cp?s=%5EGSPC&c='+i.to_s)
  end 
  #
  # Download history for a single ticker for a year.
  #
  def Scraper.downLoadHistory(ticker)
    request = Typhoeus::Request.new('http://www.google.com/finance/historical?q='+ticker+'&output=csv')
  end

  #
  # Single call to get top 50 from stock scouter
  #
  def Scraper.downLoadStockScouterTop50
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=50')
  end

  #
  # Single call only to get list of stockscouter rated 10
  #
  def Scraper.downLoadStockScouter10
    response = Typhoeus::Request.get('http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=10')
  end
  
  
end