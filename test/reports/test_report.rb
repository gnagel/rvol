# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"
require "reports/report"
require "model/stockdaily"
require 'reports/earningsreport'
class Test_Report < Test::Unit::TestCase

  #
  #
  #
  def test_report_base
    report = Report.new
    report.generateReport
    report.generateReportArgs('aapl')
    report.printAllReports
  end

  def test_earnings_report
      EarningsReport.new.generateReport
  end
end