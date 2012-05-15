# encoding: utf-8
require 'rubygems'
require 'nokogiri'
require "model/stock"
require 'csv'
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
              stock.parseDate(splitted[5])
              stock.dividendyield= splitted[6]
              stock.dpershare= splitted[7]
              begin
                Float(splitted[8])
                stock.shortratio = splitted[8]
              rescue
                puts 'no shortratio available : ' + splitted[8]
              end
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

  #
  # Downloads the S&P500 stocks and industries from wikipedia
  #
  def downloadSP500
    results = Array.new
    response = Scraper.downLoadSP500WikiPedia
    doc = Nokogiri::HTML(response.body)
    doc.css('a.external').each do |tick|
      if tick.to_s.include?('www.nyse.com') || tick.to_s.include?('www.nasdaq.com')
        symbol = tick.inner_text
        industry = "empty"

        doc.xpath("//tr").each do |tr|
          if tr.to_s.include?('www.nyse.com') || tr.to_s.include?('www.nasdaq.com')
            if(tr.to_s.include?(symbol))
              industry = tr.xpath("td[4]").inner_text
            end
          end
        end

        ticker = Ticker.new
        ticker.industry = industry
        ticker.created_at = Time.now
        ticker.symbol = symbol
        ticker.index = 'SP500'
        ticker.analystRatio = downloadRecommendation(symbol)
        ticker.save
        results << ticker
      end
    end
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

  #
  # This will download the mean recommendation value for a stock!
  #
  def downloadRecommendation(ticker)
    url = "http://finance.yahoo.com/q/ao?s=#{ticker}&ql=1"
    response = Typhoeus::Request.get(url)
    doc = Nokogiri::HTML(response.body)
    doc.xpath("//tr").each do |tr|
      if(tr.to_s.include?('Mean Recommendation (this week):'))
        mean = tr.xpath("td[2]").inner_text
        if mean !=nil && mean.length>0
        puts "#{ticker} MEAN: #{mean}"
        return mean
        end
      end
    end
  end

  def Stocks.testInternetConnection?
    Ping.pingecho "google.com", 1, 80
  end

end