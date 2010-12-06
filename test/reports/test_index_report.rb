$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "reports/indexReport"

class Test_Index_Report < Test::Unit::TestCase

  def test_Earnings_report
    begin
      DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rfinance/data/test_markettoday.db')
    IndexReport.new.generateReport
    rescue => boom
      print boom
      flunk("indexreport failed  ")
    end
  end
  
end