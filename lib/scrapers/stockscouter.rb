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
          symbol = sym.sub('/detail/stock_quote?symbol=','').chomp
          save(symbol,10)
          puts symbol
          puts i
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
          symbol = sym.sub('/detail/stock_quote?symbol=','').chomp
          save(symbol,1)
          puts symbol
          puts i
        end
      end
    end
  end
  #
  # Stores the symbol to db
  #
  def save(symbol,rating)
    ticker = Ticker.new
    ticker.symbol = symbol
    ticker.created_at = Time.now
    ticker.index = 'stockscouter-'+rating.to_s
    ticker.save
  end

end