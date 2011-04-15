# encoding: utf-8
require 'scrapers/scraper'
require 'nokogiri'
#
# Parses the tickers from fool caps top 5 star stocks with more than 100 ratings.
#
class Capsparser
  def parseCaps
    allSymbols = Array.new
    responses = Scraper.downloadFoolTop510
    responses.each do |response|
        doc = Nokogiri::HTML(response.body)
        links = doc.search('//a')
        links.each do |link|
          if link.to_html.include? '/Ticker/'
            puts link.content
          end
        end

    end
    #allSymbols.each do |symbol|
    #  symbol.each do |sym|
    #    if sym.include? '/Ticker/'
    #      i+=1
    #      #save(symbol, 10)
    #      puts sym
    #    end
    #  end
    #end
  end
end

