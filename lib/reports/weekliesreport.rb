require 'core/dateutil'
require 'model/chain'
require 'set'
require 'reports/report'
#
# Weeklies report
#
class Weekliesreport < Report
  #
  # Finds all the weeklies for this week. This is done with the date in the ticker string
  #
  def findAllWeeklies
    weeklyTickers = Set.new
    thursday = DateUtil.getFridayDateStr
    friday = DateUtil.getFridayDateStr2
    weeklies = Chain.all(:symbol.like=>'%'+thursday+'%',:symbol.like=>'%'+friday+'%')
    weeklies.each do |weekly|
      weeklyTickers << weekly.ticker
    end
    return weeklyTickers
  end

  #
  # Generate a report of weeklies
  #
  def generateReport
    scouterArray = Array.new
    findAllWeeklies.each do |tick|
      scouterArray << Stockdaily.first(:symbol=>tick)
    end
    ReportPrinter.new.printScouterStd(scouterArray)
  end

  #
  # Prints the info about this report
  #
  def printInfo
    puts 'This report will print all weeklies and their standard deviations'
  end
end