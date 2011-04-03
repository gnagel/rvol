# encoding: utf-8
require 'model/stock'
require 'model/stockdaily'
require 'reports/indexreport'
#
# Load stocks with high implied volatilities from a group of stocks
#
class IvolatilityReport
  
  #
  #
  #
  def loadStockScouter
    scouter = Array.new       
    index = Ticker.all(:index=>'stockscouter-10')
    IndexReport.new.generateReport(index)
  end
  
end