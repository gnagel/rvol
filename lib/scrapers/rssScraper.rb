require 'typhoeus'
require 'rss/2.0'
require 'hpricot'
require 'ruport'

#
# Rss scraper download market data for a particular ticker from a news rss.
# Initial implementation google.
#
class RssScraper
  def loadRSS(ticker)

    response = Typhoeus::Request.get("www.google.com/finance/company_news?q="+ticker+"&output=rss")
    rss = RSS::Parser.parse(response.body, false)

    puts "Root values"
    print "RSS title: ", rss.channel.title, "\n"
    print "RSS link: ", rss.channel.link, "\n"
    print "RSS description: ", rss.channel.description, "\n"
    print "RSS publication date: ", rss.channel.date, "\n"

    print "number of items: ", rss.items.size, "\n"

    table = Table(%w[News])

    rss.items.each{|item|
      title = item.title
      description = Hpricot(item.description).to_plain_text
      table << [description]
      #puts wrap_text(description,120)
    }
    pp table

  end

  def wrap_text(txt, col = 80)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n")
  end

  begin
    srr = RssScraper.new
    srr.loadRSS('LVS')
  end

end