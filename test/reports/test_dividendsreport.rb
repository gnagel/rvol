# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"
require "reports/report"
require "model/stockdaily"
require 'reports/DividendsReport'
class Test_Report < Test::Unit::TestCase


  #
  #
  #
  def test_earnings_report
      DividendsReport.new.generateReport
  end
end