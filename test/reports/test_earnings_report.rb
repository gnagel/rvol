$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "reports/earningsreport"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report
    begin
    DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rfinance/data/test_markettoday.db')
    EarningsReport.new.generateReport
    rescue => boom
    flunk('earnigns report failed  '+boom)
    end 
  end
  
  
end