require 'core/dateutil'
require 'model/chain'
require 'set'
require 'reports/report'
#
# Weeklies report
#
class WeekliesTopScouterReport < Report
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
    scouterArray = Array.new
    scouter = Ticker.all(:index=>'stockscouter-10',:index=>'stockscouter-50')
    symbols = scouter.collect { |x| x.symbol }

    findAllWeeklies.each do |tick|
      if symbols.include? tick
        sdaily = Stockdaily.first(:symbol=>tick)
        scouterArray << sdaily
      end
    end
    ReportPrinter.new.printScouterStd5(scouterArray)
  end

  #
  # Prints the info about this report
  #
  def printInfo
    'This report will print weeklies which are top rated in stock scouter'
  end
end

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