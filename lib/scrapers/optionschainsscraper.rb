require 'open-uri'
require 'model/chain.rb'
require 'typhoeus'
require "core/dateutil"
require 'nokogiri'
require 'benchmark'
#
# Downloads chains from yahoo and parses them to objects
# Downloads concurrently improving performance
#
class OptionChainsScraper
  #
  # load chains for the next 3 months.
  #
  def loadChains(tickers,persist)
    chains = Array.new
    # measures the time to complete
    Benchmark.bm do |x| x.report{

        scraper = OptionChainsScraper.new
        
        hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
        hydra.disable_memoization
        count=0
        tickers.each { |tick|
          date = DateTime.now
          begin
            for i in 1 .. 3
              if i > 1
                date = DateUtil.nextMonth(date)
              end
              # this is the date for the url
              parsedDate = date.strftime("%Y-%m")
              url = "http://finance.yahoo.com/q/op?s="+URI.escape(tick+"&m="+parsedDate)
              request = Typhoeus::Request.new(url)
              request.on_complete { | response |
                if(response.code==200)
                  count= count+1
                  puts 'HTTP RESPONSE: 200 '+tick + ' count: ' +count.to_s
                  doc = Nokogiri::HTML(response.body)
                  doc.search("//table[@class='yfnc_datamodoutline1']").each do |tr|
                    i = 0
                    type = ""
                    ticker = tick
                    symbol =""
                    dateS = ""
                    strike =""
                    last=""
                    chg=""
                    bid=""
                    ask=""
                    vol=""
                    open=""
                    tr.css('.yfnc_h','.yfnc_tabledata1').each do |td|
                      i+=1
                      case i
                      when 1 then strike = td.inner_text
                      when 2 then symbol = td.inner_text
                      when 3 then last   = td.inner_text
                      when 4 then chg    = td.inner_text
                      when 5 then bid    = td.inner_text
                      when 6 then ask    = td.inner_text
                      when 7 then vol    = td.inner_text
                      when 8
                        open = td.inner_text
                        if(symbol.include?"C00")
                          type = 'C'
                        else
                          type = 'P'
                        end
                        i = 0
                        if(symbol.include? DateUtil.tickerSlicer(ticker))
                          dateS = DateUtil.getDateFromOptSymbol(ticker,symbol)
                          chain = Chain.new(type,ticker,dateS,strike,symbol,last,chg,bid,ask,vol,open)
                          #puts chain.toString
                          chains << chain
                        end # end if include tickers
                      end # end case
                    end # end if responce code ==
                  end
                else
                  puts 'failed'
                  puts response.code
                  puts response.body
                end
              }
              hydra.queue(request)
            end
          end
        }
        hydra.run
        if(persist)
          persist(chains)
        end # end persist
      }
    end # end bencmark
    chains
  end

  #
  # Store into database and benchmark
  #
  def persist(chains)
    puts 'storing this many chains: ' + chains.size.to_s
    chains.each{|chain|
      if chain.save
      else
        puts 'Error saving chain'
        puts chain.ivolatility
        chain.errors.each do |e|
          puts e
        end
      end
    }
  end
end