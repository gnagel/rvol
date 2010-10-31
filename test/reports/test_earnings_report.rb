require 'helper'
require "reports/earnings_report"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report
    #earnings = Earnings_Report.loadData
    #Earnings_Report.generateReport(earnings)
    Earnings_Report.generate
  end
  
  
end