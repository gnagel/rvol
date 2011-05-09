# encoding: utf-8
require 'model/stock'
#
# Get a list of 100 top Volatility ETF:s
#
class Etf
  def parse100TopVolEtf
    response = Scraper.down100VolETF
    doc = Nokogiri::HTML(response.body)
    regex = /[A-Z]{3,4}/
    i=0
    doc.search('//tr/td').search('//a[@href]').each do |td|
      if td.content.length <= 4 && regex =~ td.content
        ticker = Ticker.new
        ticker.symbol = td.content
        next if ticker.symbol == 'ETFs'
        puts ticker.symbol
        ticker.index = 'etf'
        ticker.created_at = Time.now

        if !ticker.save
          puts 'Error saving chain'
          ticker.errors.each do |e|
            puts e
          end
        end
      end
    end
  end
end