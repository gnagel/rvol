require 'scrapers/optionschainsscraper'
# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report
 attr_accessor :earnings, :chains

def Earnings_Report.generateReport(earnings)
  
   table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])
   earnings.sort { |a,b| a.date <=> b.date }.each { |elem|
       table << [elem.date, elem.ticker, "0", "0"]
     }
  puts table
   
end
  
def Earnings_Report.attachChains(earnings)
    chains = OptionChainsScraper.loadChains(earnings.collect! {|x| x.ticker })
    chains.each{|x| puts x.symbol }
    rescue Exception
      puts $!, $@
    
    
end

end
