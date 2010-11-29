require 'typhoeus'
require 'json'
require 'hpricot'
require "model/stock"
require 'CSV'
require 'math/arraymath'

class StockScraper
  def downloadStock(tickers)
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    hydra.disable_memoization
    count = 0

    tickers.each{ | ticker|
      begin
        #url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(ticker+'&f=sl1d1t1c1ohgv&e=.csv')
        url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(ticker.to_s+'&f=l1a2vnqyd&e=.csv')
        request = Typhoeus::Request.new(url)

        request.on_complete { | response |

          if(response.code==200)
            count+=1
            puts count.to_s + ' tickers size '+tickers.size.to_s
            splitted = response.body.split(',')
            stock = StockDaily.new
            stock.symbol=ticker.to_s
            stock.price = splitted[0]
            stock.avolume = splitted[1]
            stock.volume = splitted[2]
            stock.name = splitted[3]
            stock.exdividenddate= splitted[4]
            stock.dividendyield= splitted[5]
            stock.dpershare= splitted[6]
            stock.save
          else
            puts 'failed'
            puts response.code
            puts response.body
          end
        }

        hydra.queue(request)
      rescue Exception => exp
        puts exp
      end
    }
    p 'running download stock'
    hydra.run
    p 'run finished'
  end

  def downloadStock2(tickers)
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    hydra.disable_memoization

    chunks = tickers.chunk(5)

    chunks.each{|chunk|
      puts 'running for chunk'
      csvTickers = chunk.join(',')
      begin
        url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+URI.escape(csvTickers+'&f=sl1a2vnqyd&e=.csv')
        puts csvTickers
        request = Typhoeus::Request.new(url)

        request.on_complete { | response |

          if(response.code==200)

            CSV.parse(response.body) do|row|

              splitted = row
              stock = StockDaily.new
              stock.symbol=splitted[0]
              stock.price = splitted[1]
              stock.avolume = splitted[2]
              stock.volume = splitted[3]
              stock.name = splitted[4]
              stock.exdividenddate= splitted[5]
              stock.dividendyield= splitted[6]
              stock.dpershare= splitted[7]
              stock.save
            end

            stock = StockDaily.new

          else
            puts 'failed'
            puts response.code
            puts response.body
          end
        }

        hydra.queue(request)
      rescue Exception => exp
        puts exp
      end
    }
    p 'running download stock'
    hydra.run
    p 'run finished'
  end

  def downloadStockPriceYQL(tickers)

    results = Array.new
    # do 20 concurrent at a time
    hydra = Typhoeus::Hydra.new(:max_concurrency => 1)

    tickers.each{ | ticker|
      begin

        puts ticker
        url = 'http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22'+ticker.to_s+'%22)%0A%09%09&format=json&env=http%3A%2F%2Fdatatables.org%2Falltables.env&callback='

        request = Typhoeus::Request.new(url,:timeout => 1000)
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

  def downloadSP500

    results = Array.new
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)

    for i in 0 .. 9

      url = 'http://finance.yahoo.com/q/cp?s=%5EGSPC&c='+i.to_s
      request = Typhoeus::Request.new(url)
      request.on_complete { | response |
        doc = Hpricot(response.body)
        table = doc.search("//td[@class='yfnc_tabledata1']")
        values = table.search("//a")
        values.each { |value|
          results << value.inner_text
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