# encoding: utf-8
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'
require 'reports/reportprinter'
require 'reports/report'
#
# Index report.
#
class IndexReport < Report
  def generateReport(index)
    data = Ticker.all(:index=>index,:order => [ :frontMonth.desc ])
    ReportPrinter.new.printIndexReport(data);
  end
  def printInfo
    'A report for a certain group of stocks SP500, stockscouter-10, etf  etc'
  end
end
