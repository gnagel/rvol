require 'helper'
require "reports/earnings_report"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report
   
    Earnings_Report.generate
    #Earnings_Report.generate
  end
  
  
end