require 'scrapers/optionschainsscraper'
require 'scrapers/stockscraper'
require 'scrapers/earningsscraper'
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'
# This class holds the items needed for the earnings report
# It also holds methods to generate the report into a human readable format
# The report can be printed on the command line or output as a pdf.
#
class Earnings_Report


def Earnings_Report.generate
  DataMapper.setup(:default, 'sqlite://data/markettoday.db')
  earnings = Earning.all
  Earnings_Report.generateReport(earnings)
end

def Earnings_Report.generateReport(earnings)
   table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])
   earnings.sort { |a,b| a.date <=> b.date }.each { |elem|
       table << [elem.date, elem.ticker, elem.frontMonth , elem.backMonth ]
     }
   puts table
end

#  
# Load earnings tickers and attach chains to them
#
def Earnings_Report.loadData
  
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, 'sqlite://data/markettoday.db')
    
    earning = Earning
    earnings = earning.all

    earnings.each{|e|
      ticker      = e.ticker
      osymbol     = DateUtil.getOptSymbThisMonth(ticker)
      osymbol2     = DateUtil.getOptSymbNextMonth(ticker)
      chain = Chain
      allChains = chain.all(:ticker => e.ticker)
      if(allChains.size>0)
        
        frontChains = self.getChains(allChains,osymbol)
        backChains = self.getChains(allChains,osymbol2)
      
        arrayFront = frontChains.collect{|chain| 
        if(chain!=nil&&chain.strike!=nil)
          chain.strike.to_f
        end  
        }
        
        arrayBack = backChains.collect{|chain|
            if(chain!=nil&&chain.strike!=nil)
              chain.strike.to_f
            end  
        }
        
        stock  = StockDaily.first(:symbol=>e.ticker)
        if(stock!=nil&&stock.price!=nil)
        strike1 = arrayFront.closest stock.price.to_f
        impliedVolatilities = Array.new
        impliedVolatilities2 = Array.new
        
        frontChains.each{|chain|
          if(chain.strike.to_f==strike1)
            impliedVolatilities << chain.ivolatility.to_f
          end  
        }
        
        backChains.each{|chain|
          if(chain.strike.to_f==strike1)
            impliedVolatilities2 << chain.ivolatility.to_f
          end  
        }
        puts impliedVolatilities.mean
        puts impliedVolatilities2.mean
        e.frontMonth = impliedVolatilities.mean
        e.backMonth = impliedVolatilities2.mean
        end
      end
      e.save
    }
    
    return earnings
  
end



def Earnings_Report.getChains(chains,osymbol)
  chainsA = Array.new
  chains.each{|chain|
   if (chain.symbol.include? osymbol)
     chainsA << chain
   end
  }
  chainsA
end




end
