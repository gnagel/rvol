require 'helper'
require "test/unit"
require 'reports/weekliesreport'
require 'math/calculatestd'
require 'scrapers/historicalscraper'
class Test_weekliesreport < Test::Unit::TestCase


  def test_weekliesload

    WeekliesReport.new.generateReport
  end
end