require 'helper'
require 'reports/ivolatilityreport'
require 'model/stockdaily'
#
# Report
#
class Test_ivolatilityreport < Test::Unit::TestCase
  def test_ivolatilityreport
    Stockscouter.new.parseScouterTop10
    Stockscouter.new.parseScouterTop1
    IvolatilityReport.new.loadStockScouter
    ar = Array.new
  end
end