# encoding: utf-8
require 'reports/report'
require 'model/stockdaily'
#
# Report to show dividends for the coming month
#
class DividendsReport < Report
  #
  #
  #
  def generateReport
    # get all the stocks with a dividend in the coming month
      # 60s * 60  * 24 * 30  = 30 days = 20 trading days
    date = DateTime.now
    onemonth = date + (60*60*24*30)
    dividends = Stockdaily.all(:exdividenddate.lt=>onemonth,:exdividenddate.gt=>date)

    ReportPrinter.new.printDividendsReport(dividends)
  end

  #
  #
  #
  def printInfo
     "A report showing the dividends for the next month"
  end

  def checkHasDividendts(symbol)
    dividends = Stockdaily.all(:exdividenddate.lt=>onemonth,:exdividenddate.gt=>date)
    dividends.each do |stock|
      puts 'This stock has dividends on: '+stock.symbol.to_s
      return true
    end
    return false
  end


end