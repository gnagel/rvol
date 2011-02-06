# encoding: utf-8
require 'typhoeus'
require 'nokogiri'
require "model/stock"
require 'CSV'
require 'math/arraymath'
require 'scrapers/scraper'
#
# Downloads individual stock data from yahoo.
#
class Stocks
  def downloadStock2(tickers,persist)
    stocks = Array.new
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    hydra.disable_memoization

    howmany = tickers.size/100
    if(tickers.size<101)
      chunks = [tickers]
    else
      chunks = tickers.chunk(howmany)
    end
    chunks.each{|chunk|
      csvTickers = chunk.join(',')
      begin
        
        request = Scraper.downLoadYahooCSV(csvTickers)

        request.on_complete { | response |

          if(response.code==200)

            CSV.parse(response.body) do|row|

              splitted = row
              stock = Stockdaily.new
              stock.symbol=splitted[0]
              stock.price = splitted[1]
              stock.avolume = splitted[2]
              stock.volume = splitted[3]
              stock.name = splitted[4]
              stock.exdividenddate= splitted[5]
              stock.dividendyield= splitted[6]
              stock.dpershare= splitted[7]

              stock.created_at = DateTime.now
              stocks << stock
              if persist
                if stock.save
                else
                  stock.errors.each do |e|
                    puts e
                  end
                end
              end
            end
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
    hydra.run
    stocks
  end

  def downloadSP500
    results = Array.new
    response = Scraper.downLoadSP500WikiPedia
    doc = Nokogiri::HTML(response.body)
    doc.css('a.external').each do |tick|
      if tick.to_s.include?('www.nyse.com') || tick.to_s.include?('www.nasdaq.com')
        results << tick.inner_text
      end
    end
    return results
  end

  def downloadSP500Yahoo

    results = Array.new
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    for i in 0 .. 9
     request = Scraper.downLoadSP500Yahoo(i)
      request.on_complete { | response |
        doc = Nokogiri::HTML(response.body)
        table = doc.search("//td[@class='yfnc_tabledata1']")
        values = table.search("//a")
        values.each { |value|
          results << value.inner_text
        }
      }
      hydra.queue(request)
    end
    hydra.run();
    return results
  end

  def Stocks.testInternetConnection?
    Ping.pingecho "google.com", 1, 80
  end

end