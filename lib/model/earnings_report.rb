require 'util'
require 'optionschainsscraper'
# This class holds the items needed for the earnings report
# It also hods methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report
 attr_accessor :earnings, :chains
 
def initialize(earnings)
  @earnings = earnings
  @chains = Hash.new
  parseChains
end

# load and parse the chains to the report. 3 months of chains
def parseChains
 
  chains = OptionChainsScraper.new()
  
 @earnings.getHash.each { | key, value |
  date = DateTime.now
  
  		  # get the next 3 months of chains
        date = DateTime.now
        for i in 0..3
            begin
                time = date.strftime("%Y-%m")
                @chains[time]  = chains.loadData(key,time)

            rescue => e
              puts 'LOADING TICKER: ' +key+' FAILED CARRYING ON'
      		    puts "#{e.message}\n#{e.backtrace}"

                begin
                  @chains[time] = chains.loadData(key,time)
                rescue
                  puts 'TRY NUM 2: ' +key+'  FAILED QUITING ON THIS ONE'
                end
                  
            end
            date = Util.nextMonth(date)
        end
    }

end
  



# printCommandline


# printPdf
end
