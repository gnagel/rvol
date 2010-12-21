$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "reports/earningsreport"

class TestEarnings_Report < Test::Unit::TestCase
  def test_Earnings_report
    begin
      EarningsReport.new.generateReport
    rescue => boom
      flunk('earnigns report failed  '+boom)
    end
  end

end