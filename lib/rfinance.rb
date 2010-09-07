require 'scrapers/stockscraper'
require "reports/earnings_report"

module Rfinance

# download current price for ticker
def Rfinance.loadPrice(ticker)
  StockScraper.downloadStockPrice(ticker)
end
# download earnings for this month
def Rfinance.loadEarnings
EarningsScraper.getEarningsMonth
end
# attaches the current options chains for each company in the earnings hash
def Rfinance.attachChainsToEarnings(earnings)
EarningsScraper.attachChains(earnings)
end

# generate the report
def Rfinance.generateReport(earnings)
Earnings_Report.generateReport(earnings)
end

end