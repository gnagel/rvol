# encoding: utf-8
require 'scrapers/optionschainsscraper'
require 'scrapers/stocks'
require 'ruport'
require 'reports/reportprinter'
require 'reports/report'

#
# Chains report. This class displays different reports for chains
#
class ChainsReport < Report
  #
  # Generate a report of chains for a ticker in this month
  #
  def generateReportArgs(ticker)
    chains = OptionChainsScraper.new.loadChains(ticker,false)
    filter = DateUtil.getOptSymbThisMonth(ticker)
    chains = chains.find_all{|cha|cha.symbol.include? filter }
    # get the general stock info
    stock = Stocks.new.downloadStock2([ticker],true)
    ReportPrinter.new.printChainsReportSingle(chains,stock[0])
  end
end

class ChainsReportAll < Report
  def generateReport
    chains = Chain.all
    ReportPrinter.new.printChainsReport(chains)
  end
end

class ChainsReportTop10Volume < Report
  #
  # report the chains with the most volume today
  #
  def generateReport
    chains = Chain.all(:order => [ :vol.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end
end

class ChainsTop10OpenInt < Report
  #
  # report the chains with the most open interest
  #
  def generateReport
    chains = Chain.all(:order => [ :openInt.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end
end

class ChainsTop10ImpliedVolatility < Report
  #
  # report the chains with the most open interest
  #
  def generateReport
    chains = Chain.all(:order => [ :ivolatility.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end
end

class ChainsTop10ChangeInOptionPrice < Report

  #
  # report the chains with the most open interest
  #
  def generateReport
    chains = Chain.all(:order => [ :chg.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end
end

class ChainsTop10Calls < Report

  #
  # report the chains with the most open interest
  #
  def generateReport
    tickers = Ticker.all(:order => [ :totalCalls.desc ]).first 10
    ReportPrinter.new.printTop10OptionsVolReport(tickers)
  end
end


class ChainsTop10Puts < Report
  #
  # report the chains with the most open interest
  #
  def generateReport
    tickers = Ticker.all(:order => [ :totalPuts.desc ]).first 10
    ReportPrinter.new.printTop10OptionsVolReport(tickers)
  end

end