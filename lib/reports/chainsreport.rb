# encoding: utf-8
require 'scrapers/optionschainsscraper'
require 'scrapers/stocks'
require 'ruport'
require 'reports/reportprinter'

#
# Chains report. This class displays different reports for chains
#
class ChainsReport
  #
  # Generate a report of chains for a ticker in this month
  #
  def generateReport(ticker)
    chains = OptionChainsScraper.new.loadChains(ticker,false)
    filter = DateUtil.getOptSymbThisMonth(ticker[0])
    chains = chains.find_all{|cha|cha.symbol.include? filter }
    # get the general stock info
    stock = Stocks.new.downloadStock2([ticker],true)    
    ReportPrinter.new.printChainsReportSingle(chains,stock[0])
  end

  def generateReportAll
    chains = Chain.all
    ReportPrinter.new.printChainsReport(chains)
  end

  #
  # report the chains with the most volume today
  #
  def generateReportTop10Volume
    chains = Chain.all(:order => [ :vol.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end

  #
  # report the chains with the most open interest
  #
  def generateReportTop10OpenInt
    chains = Chain.all(:order => [ :openInt.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end

  #
  # report the chains with the most open interest
  #
  def generateReportTop10ImpliedVolatility
    chains = Chain.all(:order => [ :ivolatility.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end

  #
  # report the chains with the most open interest
  #
  def generateReportTop10ChangeInOptionPrice
    chains = Chain.all(:order => [ :chg.desc ]).first 10
    ReportPrinter.new.printChainsReport(chains)
  end

  #
  # report the chains with the most open interest
  #
  def generateReportTop10Calls
    tickers = Ticker.all(:order => [ :totalCalls.desc ]).first 10
    ReportPrinter.new.printTop10OptionsVolReport(tickers)
  end

  #
  # report the chains with the most open interest
  #
  def generateReportTop10Puts
    tickers = Ticker.all(:order => [ :totalPuts.desc ]).first 10
    ReportPrinter.new.printTop10OptionsVolReport(tickers)
  end

end