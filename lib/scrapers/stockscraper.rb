require 'typhoeus'
require 'json'
require 'hpricot'
require "model/stock"
require 'CSV'
require 'math/arraymath'

class StockScraper
 
  def downloadStock2(tickers)

    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    hydra.disable_memoization

    howmany = tickers.size/100
    if(tickers.size<101)
      chunks = [tickers]
    else
      chunks = tickers.chunk(howmany)
    end
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
              
              stock.created_at = DateTime.now 

              if stock.save
              else
                stock.errors.each do |e|
                  puts e
                end
              end

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