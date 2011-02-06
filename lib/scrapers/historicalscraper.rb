# encoding: utf-8
require 'CSV'
require 'typhoeus'
require 'thread'

#
# Downloads 1 year of historical data for given ticker
#
class Historicalscraper
  @@queue = Queue.new
  def downloadHistoricalData(ticker,persist)
    hydra = Typhoeus::Hydra.new
    thread = storingthread
    count=0
    ticker.each do |ticker|
      request = Scraper.downLoadHistory(ticker)
      request.on_complete { | response |
        if(response.code==200)
          count+=1
          puts 'HTTP RESPONSE: 200 '+ticker + ' count: ' +count.to_s
          begin
            CSV.parse(response.body,:headers => :first_row) do |row|
              history = StockHistorical.new
              history.date = row[0]
              history.open  = row[1]
              history.high = row[2]
              history.low = row[3]
              history.close = row[4]
              history.volume = row[5]
              if persist
                @@queue << history
              end
            end
          rescue => boom
            puts boom
          end
        end
      }
      hydra.queue(request)
    end
    hydra.run
    if(@@queue.empty?)
      thread.exit
    end
  end

  #
  # A thread that monitors storage stuff
  #
  def storingthread
    thread = Thread.new do
      loop do
        # pop will block until there are queue items available
        history = @@queue.pop
        if history.save
        else
          puts 'Error saving history'
          history.errors.each do |e|
            puts e
          end
        end
      end
    end
    return thread
  end

end