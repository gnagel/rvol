# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"
require "reports/correlationSTDreport"
require "model/stockdaily"

class Test_CorrelationSTDreport < Test::Unit::TestCase
  def test_correlationsreport
   testdata
    # run test
    CorrelationSTDreport.new.calculateCorrelations()
    puts 'loading all correlations'
    CorrelationSTDreport.new.loadAllCorrelations()
  end
  
  
  private 
  def testdata
    Ticker.all.destroy
    Stockdaily.all.destroy
    # default adater for all db action stored in gem home directory
     # Make this into a test dataaset for all
     # 1. Save tickers
     ticker = Ticker.new
     ticker.symbol = 'SPY'
     ticker.created_at = Time.now
     ticker.index='etf'
     if ticker.save
     else
       ticker.errors.each do |e|
         puts e
       end
     end
     ticker = Ticker.new
     ticker.symbol = 'EWJ'
     ticker.created_at = Time.now
     ticker.index='etf'
     ticker.save
     puts 'DEB'
     ticker = Ticker.new
     ticker.symbol = 'QQQ'
     ticker.created_at = Time.now
     ticker.index='etf'
     ticker.save
     ticker = Ticker.new
     ticker.symbol = 'GLD'
     ticker.created_at = Time.now
     ticker.index='etf'
     ticker.save
     ticker = Ticker.new
     ticker.symbol = 'VXX'
     ticker.created_at = Time.now
     ticker.index='etf'
     ticker.save
     # 2. Save stock data
     puts 'DEEEEGBUG'
     result = Ticker.all
     Stocks.new.downloadStock2(result.collect{|tic| tic.symbol},true)
     puts 'DEEEEGBUG'
     # 3. Save historical
     Historicalscraper.new.downloadHistoricalData(Stockdaily.all,true)
  end
end