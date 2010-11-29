require 'helper'
require "reports/indexReport"

class Test_Index_Report < Test::Unit::TestCase

  def test_Earnings_report
    IndexReport.new.generateReport
  end
  
end