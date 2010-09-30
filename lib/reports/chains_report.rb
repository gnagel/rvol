require 'scrapers/optionschainsscraper'
require 'scrapers/stockscraper'
require 'ruport'

# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Chains_Report
 attr_accessor :earnings, :chains

def Chains_Report.generateReport(ticker)
  
   chains = OptionChainsScraper.loadChains(ticker)
   
   filter = DateUtil.getOptSymbThisMonth(ticker)
  
   fchains = chains.find_all{|cha|cha.symbol.include? filter }
   
   table = Table(%w[Type Ticker Expmonth Days Strike Symbol Last Chg Bid Ask Vol openInt LastPrice ImpliedVolatility])
   fchains.each { |elem|
           table << [elem.type, elem.ticker, elem.date,elem.expTime, elem.strike, elem.symbol,elem.last,elem.chg,elem.bid,elem.ask,
           elem.vol,elem.openInt,elem.lastPrice,"%0.2f" % (elem.ivolatility*100)+'%' ]
     }
  puts table
   
end

end

