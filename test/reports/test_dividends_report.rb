# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "reports/earningsreport"

class TestEarnings_Report < Test::Unit::TestCase

  def setup
    Stockscouter.new.parseScouterTop10
     result = Ticker.all()
     Stocks.new.downloadStock2(result.collect{|tic| tic.symbol},true)
  end

  def test_Earnings_report
    begin
      EarningsReport.new.generateReport
    rescue => boom
      flunk('earnigns report failed  '+boom)
    end
  end

end