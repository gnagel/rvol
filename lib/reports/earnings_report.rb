require 'scrapers/optionschainsscraper'
# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report
 attr_accessor :earnings, :chains

def Earnings_Report.generateReport(earnings)
  
  table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])

   earnings.getHash.sort{|a,b| a[1]<=>b[1]}.each { |elem|

        table << [elem[1], elem[0].ticker, "0", "0"]
   }
   
end
  
# printCommandline

  
  def loadVolatilityForFrontMonth
    
    # get this months chains
    String thisMonth = DateUtil.dateParsed(DateTime.now)
    earnings.get
     #load this month 
     less_than = []
     greater_than = []

     a.each do |elmt|
       if elmt < target
         less_than << elmt

       elsif elmt > target
         greater_than << elmt
       end
     end

     puts less_than.max
     puts greater_than.min

   end






end
