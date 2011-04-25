# encoding: utf-8
require 'Rvol'
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

  end
  #
  #
  #
  def printInfo

  end
  #
  #
  #
  def parseDate
    Stockdaily.all.each do |stock|
      date = stock.exdividenddate
      puts stock.symbol
      if date.length == 6
        puts date
        formated = Date.strptime(date,'m%,d%')
        puts formated
      end
      if date.length == 9
        puts date
      end
      if date.length == 3
        puts date
      end
    end

  end

end