require 'core/dateutil'
require 'model/chain'
require 'set'
require 'reports/report'
#
# Weeklies report
#

class WeekliesReport< Report
  #
  # Finds all the weeklies for this week. This is done with the date in the ticker string
  #
  def findAllWeeklies
    weeklyTickers = Set.new
    friday = DateUtil.getFridayDateStr
    thursday = DateUtil.getFridayDateStr2
    weeklies = Chain.all(:symbol.like=>'%'+friday+'%')
    weeklies.each do |weekly|
      weeklyTickers << weekly.ticker
    end
    return weeklyTickers
  end

  #
  # Generate a report of weeklies
  #
  def generateReport
    array = Array.new
    findAllWeeklies.each do |tick|
        sdaily = Stockdaily.first(:symbol=>tick)
        array << sdaily
    end
    ReportPrinter.new.printScouterStd5(array)
  end

  #
  # Prints the info about this report
  #
  def printInfo
    'This report will print all weeklies with their standard deviations'
  end
end