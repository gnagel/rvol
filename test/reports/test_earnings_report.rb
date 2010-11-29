require 'helper'
require "reports/earningsreport"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report
    begin
    EarningsReport.new.generateReport
    rescue => boom
      print boom
    flunk('earnigns report failed')
    end 
  end
  
  
end