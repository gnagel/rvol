require 'helper'
require 'reports/ivolatilityreport'
require 'model/stockdaily'
#
# Report
#
class Test_ivolatilityreport < Test::Unit::TestCase
  def test_ivolatilityreport

    IvolatilityReport.new.generateReport

  end
end