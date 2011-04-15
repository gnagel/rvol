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
end

#
#   Prints the top 20 scouter standards deviation report
#
class Stdreporttop20scouter < Report
  def generateReport
    scouter = Ticker.all(:index=>'stockscouter-10')
    scouterArray = Array.new
    scouter.each do |tick|
      scouterArray << Stockdaily.first(:symbol=>tick.symbol)
    end
    ReportPrinter.new.printScouterStd(scouterArray)
  end
end

#
#   Prints the shit 20 scouter standards deviation report
#
class Stdreportshit20scouter < Report
  def generateReport
    scouter = Ticker.all(:index=>'stockscouter-1')
    scouterArray = Array.new
    scouter.each do |tick|
      scouterArray << Stockdaily.first(:symbol=>tick.symbol)
    end
    ReportPrinter.new.printScouterStd(scouterArray)
  end
end