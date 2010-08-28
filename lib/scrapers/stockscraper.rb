require 'open-uri'

class StockScraper

@cachedStock = {}

def StockScraper.downloadStockPrice(ticker)
    if @cachedStock[ticker]==nil
   
      url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(ticker+'&f=sl1d1t1c1ohgv&e=.csv')
      open(url) { |f|
      file =  f.read
      p file
      splitted = file.split(',')
      @cachedStock[ticker] = splitted[1]
      return  @cachedStock[ticker]
      }
    end
    return @cachedStock[ticker]
end




def StockScraper.testInternetConnection?
   Ping.pingecho "google.com", 1, 80
end

end