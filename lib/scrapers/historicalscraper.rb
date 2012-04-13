# encoding: utf-8
require 'csv'
require 'typhoeus'
require 'thread'
require 'scrapers/scraper'
#
# Downloads 1 year of historical data for given ticker
#
class Historicalscraper
  def downloadHistoricalData(stocks,persist)
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    hydra.disable_memoization
    count=0

    stocks.each do |ticker|
      request = Scraper.downLoadHistory(ticker.symbol)
      request.on_complete { | response |
        if(response.code==200)
          dates = Stockhistorical.all(:symbol=>ticker.symbol).collect { |tic| tic.date }
          count+=1
          puts 'HTTP RESPONSE: 200 Historical  '+ticker.symbol + ' count: ' +count.to_s
          begin
            CSV.parse(response.body,:headers => :first_row) do |row|
              history = Stockhistorical.new
              history.symbol = ticker.symbol
              history.date = row[0]
              history.open  = row[1]
              history.high = row[2]
              history.low = row[3]
              history.close = row[4]
              history.volume = row[5]
              if persist && !dates.include?(history.date)
                if history.save
                else
                  puts 'Error saving history'
                  history.errors.each do |e|
                    puts e
                  end
                end
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
  end
end