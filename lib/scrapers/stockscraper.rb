require 'typhoeus'

class StockScraper

@@cachedStock = {}
@@hydra = Typhoeus::Hydra.new

def StockScraper.downloadStockPrice(ticker)
    if @@cachedStock[ticker]==nil
    
     
      url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(ticker+'&f=sl1d1t1c1ohgv&e=.csv')
      request = Typhoeus::Request.new(url)
    
      request.on_complete { | response |
        file =  response.body
        p file
        splitted = file.split(',')
        @@cachedStock[ticker] = splitted[1]
      }
    
      @@hydra.queue(request)      
      @@hydra.run
      return  @@cachedStock[ticker]
    end
    
    return @@cachedStock[ticker]
end

def StockScraper.testInternetConnection?
   Ping.pingecho "google.com", 1, 80
end

end