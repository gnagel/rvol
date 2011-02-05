# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"
require "reports/chainsreport"

class Test_Chains_Report < Test::Unit::TestCase
  @@once = false
  def setup
    if(!@@once)
      ticker = ['AAPL','LVS','GOOG','SPY']
      chains = OptionChainsScraper.new.loadChains(ticker,true)
    end
    @@once = true
  end

  def test_Chains_report
    begin
      ChainsReport.new.generateReport(['ADBE'])
    rescue => boom
      flunk('chainreport failed '+ boom.to_s)
    end
  end

  def test_Chains_top10volreport

    begin
      ChainsReport.new.generateReportTop10Volume
    rescue => boom
      flunk('chainreport VOL failed '+ boom.to_s)
    end
  end

  def test_Chains_top10openIntReport
    begin
      ChainsReport.new.generateReportTop10OpenInt
    rescue => boom
      flunk('chainreport OpenInt failed '+ boom.to_s)
    end
  end

  def test_Chains_ImpliedVolatilityReport
    begin
      ChainsReport.new.generateReportTop10ImpliedVolatility
    rescue => boom
      flunk('chainreport Implied Vol failed '+ boom.to_s)
    end
  end

  def test_Chains_Top10ChabgeInPrice
    begin
      ChainsReport.new.generateReportTop10ChangeInOptionPrice
    rescue => boom
      flunk('chainreport generateReportTop10ChangeInOptionPrice failed '+ boom.to_s)
    end
  end

end