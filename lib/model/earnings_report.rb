require 'util'
require 'optionschainsscraper'
# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
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
@earnings = EarningsScraper.attachChains(@earnings)
end
  



# printCommandline


# printPdf
end
