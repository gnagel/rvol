require 'scrapers/optionschainsscraper'
require 'scrapers/stockscraper'
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
    ReportPrinter.new.printChainsReport(chains)
  end

end