require 'helper'
require 'reports/Sdreport'
#
# Report
#
class Test_sdreport < Test::Unit::TestCase
  def test_sdreport
    puts 'running test'
    Historicalscraper.new.downloadHistoricalData(['IBM','IWM'],true)
    report = Sdreport.new
    report.loadTickers
  end
end