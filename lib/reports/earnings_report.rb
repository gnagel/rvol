require 'scrapers/optionschainsscraper'
require 'scrapers/stockscraper'
require 'scrapers/earningsscraper'
require 'ruport'

# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report


def Earnings_Report.generate
  earnings = Earnings_Report.loadData
  Earnings_Report.generateReport(earnings)
end

def Earnings_Report.generateReport(earnings)
  
   table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])
   earnings.sort { |a,b| a.date <=> b.date }.each { |elem|
       table << [elem.date, elem.ticker,"%0.2f" % (elem.frontMonth*100)+'%',"%0.2f" % (elem.backMonth*100)+'%']
     }
  puts table
   
end

#  
# Load earnings tickers and attach chains to them
#
def Earnings_Report.loadData
    
    earnings = EarningsScraper.getEarningsMonth2
    chains = OptionChainsScraper.loadChains(earnings.collect {|x| x.ticker })

    earnings.each{ |earning|
      
      # gets the beginning of option symbols for this month and next 
      optSymb1  = DateUtil.getOptSymbThisMonth(earning.ticker)
      optSymb2 = DateUtil.getOptSymbNextMonth(earning.ticker)
      
      front1 = self.filterCallChains(optSymb1,chains,'C00')
      front2 = self.filterCallChains(optSymb1,chains,'P00')
      back1  = self.filterCallChains(optSymb2,chains,'C00')
      back2  = self.filterCallChains(optSymb2,chains,'P00')
      
      earning.frontMonth = (Earnings_Report.closest(front1)+Earnings_Report.closest(front2))/2
      earning.backMonth = (Earnings_Report.closest(back1)+Earnings_Report.closest(back2))/2
   
    }
    earnings
    
end

#
#Filter all call chains for certain symbol
#
def Earnings_Report.filterCallChains(symbol,chain,type)
   fchains = chain.find_all{|cha|cha.symbol.include? symbol }
   fchains2 = fchains.find_all{|cha|cha.symbol.include? type }
   fchains2.each{ |chain|
     chain.calculateIVol
   }
end

def Earnings_Report.closest(chains)
     
      sorted = chains.sort {|a,b| (b.strike.to_f-b.lastPrice.to_f).abs <=> (a.strike.to_f-a.lastPrice.to_f).abs}
      if(sorted.last!=nil) 
        return sorted.last.ivolatility
      end
      0
end





end
