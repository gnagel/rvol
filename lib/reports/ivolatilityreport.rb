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
    IndexReport.new.generateReport('stockscouter-10')
  end
  
end