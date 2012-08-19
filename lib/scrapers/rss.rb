# encoding: utf-8
require 'typhoeus'
require 'rss/2.0'
require 'ruport'
require 'nokogiri'

#
# Rss scraper download market data for a particular ticker from a news rss.
# Initial implementation google.
#
class RssScraper
  def loadRSS(ticker)

    response = Typhoeus::Request.get("www.google.com/finance/company_news?q="+ticker+"&output=rss",:timeout=>3000)
    rss = RSS::Parser.parse(response.body, false)
    table = Table(%w[Num Date News])
    count = 0
    rss.items.each { |item|
      count+=1
      title = item.title[0, 100]
      table << [count, item.date.strftime("%d/%m/%y at %I:%M%p"), title]

    }

    print table
    puts 'type rvol -n '+ticker +' Num to open specific news page'

  end

  def opennews(ticker, number)
    response = Typhoeus::Request.get("www.google.com/finance/company_news?q="+ticker+"&output=rss",:timeout=>3000)
    rss = RSS::Parser.parse(response.body, false)
    table = Table(%w[Date News])
    count = 0
    found = false
    rss.items.each { |item|
      count+=1
      if count==number.to_i
        Tools.new.openwebpage(item.link)
        found = true
        break
      end
    }
    if !found
      puts 'Couldnt load news'
    end
  end

end