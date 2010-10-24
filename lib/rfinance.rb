require 'rubygems'
require 'scrapers/stockscraper'
require "reports/earnings_report"
require 'optparse'
require 'dm-core'

module Rfinance

# download current price for ticker
def Rfinance.loadPrice(ticker)
  StockScraper.downloadStockPrice(ticker)
end


# generate the report
def Rfinance.generateReport
  Earnings_Report.generateReport(earnings)
end

end