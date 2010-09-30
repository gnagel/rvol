require 'helper'
require "model/earnings"
require "reports/chains_report"

class Test_Chains_Report < Test::Unit::TestCase

  def test_Chains_report
    
  start_time = Time.now 
  Chains_Report.generateReport("ADBE")
  total_time = Time.now - start_time 
  puts total_time
  
  rescue => e
    p e
  end
  
  
end