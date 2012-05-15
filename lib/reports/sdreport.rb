require 'math/arraymath'
require 'reports/reportprinter'
require 'reports/report'
#
# A report with different standard deviation spikes.
#
class Sdreport < Report
  #
  # Report the chains with highest tandard deviation spice
  #
  def generateReport
    tickers = Stockdaily.all(:order => [:std20.desc]).first 20
    ReportPrinter.new.printTop50SdevReport(tickers)
  end

  def printInfo
    'Prints the top 50 standard deviations from the whole universe of stock (S&P500,ETF:s)'
  end
end
