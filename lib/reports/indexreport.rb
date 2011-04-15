# encoding: utf-8
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'
require 'reports/reportprinter'
require 'reports/report'

class IndexReport < Report
  def generateReport(index)
    data = Ticker.all(:index=>index,:order => [ :frontMonth.desc ])
    ReportPrinter.new.printIndexReport(data);
  end
end
