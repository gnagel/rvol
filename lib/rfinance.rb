require 'scrapers/stockscraper'

module Rfinance

# download current price for ticker
def Rfinance.loadPrice(ticker)
  StockScraper.downloadStockPrice(ticker)
end
# download earnings for this month
def Rfinance.loadEarnings
@earnings = EarningsScraper.getEarningsMonth
end
# attaches the current options chains for each company in the earnings hash
def Rfinance.attachChainsToEarnings(earnings)
earnings = EarningsScraper.attachChains(earnings)
end

end