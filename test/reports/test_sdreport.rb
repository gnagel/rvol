require 'helper'
require 'reports/Sdreport'
require 'model/stockdaily'
#
# Report
#
class Test_sdreport < Test::Unit::TestCase
  def test_sdreport
    begin

      Sdreport.new.generateReport
      Stdreporttop20scouter.new.generateReport
      Stdreportshit20scouter.new.generateReport
    rescue => e
      flunk(e)
    end
  end
end