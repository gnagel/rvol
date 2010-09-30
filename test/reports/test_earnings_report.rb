require 'helper'
require "model/earnings"
require "reports/earnings_report"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report
    earnings = Earnings_Report.loadData
    Earnings_Report.generateReport(earnings)
  end
  
  
end