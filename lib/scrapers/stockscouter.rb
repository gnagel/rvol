require 'nokogiri'
# encoding: utf-8
#
# Downloads top lists from stock scouter
# Uses regex to find all symbols as Nokogiri could not parse the page for some reason
#
class Stockscouter
  #
  # Parse stock symbols from stock scouter rated 10
  #
  def parseScouterTop10
    response = Scraper.downLoadStockScouterTop1050
    response2 = Scraper.downLoadStockScouterTop10100
    parsed = response.body.scan(/<a href=\"([^\"]*)\">(.*)<\/a>/)
    parsed2 = response2.body.scan(/<a href=\"([^\"]*)\">(.*)<\/a>/)
    allSymbols = parsed | parsed2
    i = 0
    allSymbols.each do |symbol|
      symbol.each do |sym|
        if sym.include? '/detail/stock_quote?symbol='
          i+=1
          symbol = sym.sub('/detail/stock_quote?symbol=', '').chomp
          save(symbol, 10)
          puts symbol
        end
      end
    end
  end

  #
  # Parses the tickers from the page rated 1
  #
  def parseScouterTop1
    response = Scraper.downLoadStockScouterTop150
    response2 = Scraper.downLoadStockScouterTop1100
    parsed = response.body.scan(/<a href=\"([^\"]*)\">(.*)<\/a>/)
    parsed2 = response2.body.scan(/<a href=\"([^\"]*)\">(.*)<\/a>/)
    allSymbols = parsed | parsed2
    i = 0
    allSymbols.each do |symbol|
      symbol.each do |sym|
        if sym.include? '/detail/stock_quote?symbol='
          i+=1
          symbol = sym.sub('/detail/stock_quote?symbol=', '').chomp
          save(symbol, 1)
          puts symbol
        end
      end
    end
  end

  #
  # Parses the tickers from the page rated 1
  #
  def parseScouterTop50
    response = Scraper.downLoadStockScouterTop50
    doc = Nokogiri::HTML(response.body)
    links = doc.css('a')
    links.each do |link|
      if link.attribute('href').to_s.include? 'http://investing.money.msn.com/investments/stock-price?symbol='
        save(link.content, TOP50)
        puts link.content
      end
    end
  end

  #
  # Parses the tickers from the page rated 1
  #
  def parseScouterTop10List
    response = Scraper.downLoadStockScouter10
    doc = Nokogiri::HTML(response.body)
    links = doc.css('a')
    links.each do |link|
      if link.attribute('href').to_s.include? 'http://investing.money.msn.com/investments/stock-price?symbol='
        save(link.content, TOP10)
        puts link.content
      end
    end
  end

  #
  # Stores the symbol to db
  #
  def save(symbol, rating)
    index = 'stockscouter-'+rating.to_s
    ticker = Ticker.create(:symbol=>symbol, :created_at=>Time.now, :index=>index)
  end

end