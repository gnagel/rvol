require 'helper'
require "model/earnings"
require "reports/earnings_report"

class TestEarnings_Report < Test::Unit::TestCase

  def test_Earnings_report1
    earn = Earnings.new(DateTime.now)
    earn.put('LVS','20100831')
  
  
    report = Earnings_Report.new(earn)
    puts 'Got these chains:::'
    puts report.chains.keys
  
  rescue => e
    p e
  end
  
  
end