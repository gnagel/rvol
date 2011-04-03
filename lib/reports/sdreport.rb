require 'math/arraymath'
#
# A report with different standard deviation spikes.
#
class Sdreport

  #
  # Report the chains with the most open interest
  #
  def generateReportTop50StandardDeviation
    tickers = Stockdaily.all(:order => [ :std20.desc ]).first 20
    ReportPrinter.new.printTop50SdevReport(tickers)
  end
  
end