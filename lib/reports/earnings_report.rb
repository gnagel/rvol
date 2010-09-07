require 'scrapers/optionschainsscraper'
# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report
 attr_accessor :earnings, :chains

def Earnings_Report.generateReport(earnings)
  
   table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])
   earnings.each { |elem|
       table << [elem.date, elem.ticker, "0", "0"]
     }
  puts table
   
end
  

  
def loadVolatilities
    
  
end






end
