# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "reports/indexReport"

class Test_Index_Report < Test::Unit::TestCase
  def test_Earnings_report
    begin
       EarningsReport.new.generateReport
    rescue => boom
      print boom
      flunk("earningsreport failed  ")
    end
  end

end