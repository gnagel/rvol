# encoding: utf-8
require 'CSV'
require 'typhoeus'

#
# Downloads 1 year of historical data for given ticker
#
class Historicalscraper
  def self.downloadHistoricalData(ticker,persist)
    hydra = Typhoeus::Hydra.new
    ticker.each do |ticker|
      request = Scraper.downLoadHistory(ticker)
      request.on_complete { | response |
        CSV.parse(response.body,:headers => :first_row) do |row|
          puts row
          history = StockHistorical.new
          history.date = row[0]
          history.open  = row[1]
          history.high = row[2]
          history.low = row[3]
          history.close = row[4]
          history.volume = row[5]
          if persist
            history.save
          end
        end
      }
      hydra.queue(request)
    end
    hydra.run
  end
end