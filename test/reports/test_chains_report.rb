require 'helper'
require "model/earning"
require "reports/chainsreport"

class Test_Chains_Report < Test::Unit::TestCase

  def test_Chains_report
    
  start_time = Time.now 
  ChainsReport.new.generateReport(['ADBE'])
  total_time = Time.now - start_time 
  puts total_time

  end
  
  
end