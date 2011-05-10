# encoding: utf-8
require 'model/stock'
require 'model/stockdaily'
require 'reports/indexreport'
require 'reports/report'
#
# Load stocks with high implied volatilities from a group of stocks
#
class IvolatilityReport < Report
  
  #
  #
  #
  def generateReport
    IndexReport.new.generateReport('stockscouter-10')
  end

  def printInfo
    'A report of stock scouter top 10 stocks odered by their implied volatilities'
  end
  
end