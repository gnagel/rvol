# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"
require "reports/chainsreport"
require "model/stockdaily"
class Test_Chains_Report < Test::Unit::TestCase


  def test_Chains_report
    begin
      ChainsReport.new.generateReport()
    rescue => boom
      flunk('chainreport failed '+ boom.to_s)
    end
  end


end