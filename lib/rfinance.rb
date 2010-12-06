require 'reports/earningsreport'

#
#
#
module Rfinance
  def earningsReport
    EarningsReport.new.generateReport
  end
end