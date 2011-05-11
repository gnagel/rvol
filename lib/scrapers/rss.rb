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

    response = Typhoeus::Request.get("www.google.com/finance/company_news?q="+ticker+"&output=rss")
    rss = RSS::Parser.parse(response.body, false)

    puts  "Root values"
    print "RSS title: ", rss.channel.title, "\n"
    print "RSS link: ", rss.channel.link, "\n"
    print "RSS description: ", rss.channel.description, "\n"
    print "RSS publication date: ", rss.channel.date, "\n"

    print "number of items: ", rss.items.size, "\n"

    table = Table(%w[Date News])

    rss.items.each{|item|
      title = item.title[0,100]
      description = item.link
      table << [item.date.strftime("%d/%m/%y at %I:%M%p"),title]
    }

    print table

  end

end