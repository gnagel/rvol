require 'helper'
require 'reports/Sdreport'
require 'model/stockdaily'
#
# Report
#
class Test_sdreport < Test::Unit::TestCase
  def test_sdreport
    puts 'running test'
    #clean up
    Stockdaily.all.destroy
    stock =  Stockdaily.new
    stock.symbol = "IBM"
    stock.created_at = DateTime.now
    stock.price = 12.1
    stock.avolume =23
    stock.volume = 3
    stock.name = "International machines bus"
    stock.save
    stock =  Stockdaily.new
    stock.symbol = "IWM"
    stock.created_at = DateTime.now
    stock.price = 0.1
    stock.avolume =42323
    stock.volume = 3212
    stock.name = "Ishares mw"
    stock.save
    stock = Stockdaily.all
    Historicalscraper.new.downloadHistoricalData(stock,true)
    report = Sdreport.new
    report.calculateStd
    report.generateReportTop50StandardDeviation
  end
end