require 'typhoeus'
require 'json'
require 'hpricot'

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


def StockScraper.downloadStockPriceYQL(tickers)

results = Array.new
# do 20 concurrent at a time
hydra = Typhoeus::Hydra.new(:max_concurrency => 20)

tickers.each{ | ticker|
begin
      
puts ticker
url = 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22'+ticker.to_s+'%22)%0A%09%09&format=json&env=http%3A%2F%2Fdatatables.org%2Falltables.env&callback='

    request = Typhoeus::Request.new(url)
    request.on_complete { | response |
    puts response.code
    
    stock = Stock.new
   
    # this will introspect the values into the model 
    JSON.parse(response.body)['query']['results']['quote'].each{ |key,value|
      dkey = key.sub(/\b\w/) { $&.downcase }
      stock.send(dkey + '=' , value)
      puts key
      puts value
      }
      results << (stock)
     
    }
rescue Exception => e
puts e
end
hydra.queue(request)

}
      
hydra.run();

return results
end



def StockScraper.downloadSP500
  
  results = Array.new
  hydra = Typhoeus::Hydra.new
  
  for i in 0 .. 9
 
      url = 'http://finance.yahoo.com/q/cp?s=%5EGSPC&c='+i.to_s
      request = Typhoeus::Request.new(url)
      request.on_complete { | response |
      doc = Hpricot(response.body)  
      table = doc.search("//td[@class='yfnc_tabledata1']")
      values = (table/"//a")
      values.each { |value|
        results << (value.inner_text) 
        }
      }
      hydra.queue(request)
  end


  hydra.run();

  results
end 


def StockScraper.testInternetConnection?
   Ping.pingecho "google.com", 1, 80
end

end