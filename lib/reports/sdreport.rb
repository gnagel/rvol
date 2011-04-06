require 'math/arraymath'
require 'reports/reportprinter'
#
# A report with different standard deviation spikes.
#
class Sdreport

  #
  # Report the chains with highest tandard deviation spice
  #
  def generateReportTop50StandardDeviation
    tickers = Stockdaily.all(:order => [ :std20.desc ]).first 20
    ReportPrinter.new.printTop50SdevReport(tickers)
  end

  #
  # Report the chains with the most open interest
  #
  def generateReportTop20StandardDeviationScouter
    scouter = Ticker.all(:index=>'stockscouter-10')
    scouterArray = Array.new
    scouter.each do |tick|
      scouterArray << Stockdaily.first(:symbol=>tick.symbol)
    end
    ReportPrinter.new.printScouterStd(scouterArray)
  end
end