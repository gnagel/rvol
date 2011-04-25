require 'reports/report'
#
# Report to show dividends for the coming month
#
class DividendsReport < Report
  #
  #
  #
  def generateReport

  end
  #
  #
  #
  def printInfo

  end

  def parseDate
    StockDaily.all.each do |stock|
     puts stock.exdividenddate
    end
  end

end