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
    'Prints the top 50 standard deviations from the whole universe of stock (S&P500, Stock scouter, top 100 ETF:s)'
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
      if tick!=nil
        scouterArray << Stockdaily.first(:symbol=>tick.symbol)
      end
    end
    ReportPrinter.new.printScouterStd20(scouterArray)
  end
  def printInfo
    'A report that shows the top Standard deviations in the Stock scouter top rated stocks look'
  end
end

#
#   Prints the top 20 scouter standards deviation report
#
class Stdreporttop5scouter < Report
  def generateReport
    scouter = Ticker.all(:index=>'stockscouter-10')
    scouterArray = Array.new
    scouter.each do |tick|
      scouterArray << Stockdaily.first(:symbol=>tick.symbol)
    end
    ReportPrinter.new.printScouterStd5(scouterArray)
  end
  def printInfo
    'A report that shows the top Standard deviations in the Stock scouter top rated stocks look'
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
    ReportPrinter.new.printScouterStd20(scouterArray)
  end
   def printInfo
    'A report that shows the top Standard deviations in the Stock scouter worst rated stocks'
  end
end