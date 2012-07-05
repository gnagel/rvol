# encoding: utf-8
require 'reports/reportprinter'
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'model/stockdaily'
require 'ruport'
require 'reports/report'
#
# This class holds the items needed for the earnings report
# The report can be printed on the command line or output as a pdf.
#
class EarningsReport < Report
  def generateReport
    ReportPrinter.new.printEarningsReport(loadData)
  end

  def printInfo
    'A report with the coming earnings for the next month with front and back month implied volatilities '
  end

  #
  # Load earnings only for sp500 and get the front and back month values
  #
  def loadData
    earray = Array.new
    earnings = Earning.all
    sp500 = Ticker.all(:indexName=>'SP500')
    sp500.each do |sp|
      ticker = Earning.first(:ticker=>sp.symbol)
      if ticker!=nil
        ticker.frontMonth = sp.frontMonth
        ticker.backMonth = sp.backMonth
        ticker.save
        earray << ticker
      end
    end
    return earray
  end

  def checkHasEarnings(ticker)
    Earning.all.each do |earning|
      if ticker == earning.ticker
        puts 'This stock has earnings on: '+ earning.date
        return true
      end
    end
    return false
  end


end
