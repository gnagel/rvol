require 'helper'
require "reports/index_etf_report"

class Test_Index_Report < Test::Unit::TestCase

  def test_Earnings_report
    Index_Etf_report.generateReport
  end
  
end