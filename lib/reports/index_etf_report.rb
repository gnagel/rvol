
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'

class Index_Etf_report

  def Index_Etf_report.generateReport
    
    indexes = Index_Etf_report.loadData
    
    puts "".ljust(75,"*") << "\n" 
    puts ""  +"index report"+"\n" 
    puts "".ljust(75,"*") << "\n" 
   
    
    table = Table(%w[Ticker impliedVolatility1 impliedvolatility2 difference])
    indexes.each { | elem |
      begin
        difference = "%0.2f" %(elem.frontMonth-elem.backMonth)
      rescue
      end
      table << [elem.symbol, Index_Etf_report.checkValue(elem.frontMonth), Index_Etf_report.checkValue(elem.backMonth),difference]
    }
    puts table
  end

  def Index_Etf_report.checkValue(value)
    if(value=='nan'||value==nil)
      return ''
    end
    return value
  end

  #  
  # Load earnings tickers and attach chains to them
  #
  def Index_Etf_report.loadData  

    indexes = Ticker.all(:index=>'index-etf')

    indexes.each{ | e |
      ticker      = e.symbol
      osymbol     = DateUtil.getOptSymbThisMonth(ticker)
      osymbol2     = DateUtil.getOptSymbNextMonth(ticker)
      chain = Chain
      allChains = chain.all(:ticker => e.symbol)
      if(allChains.size>0)

        frontChains = self.getChains(allChains,osymbol)
        backChains = self.getChains(allChains,osymbol2)

        arrayFront = frontChains.collect{ | chain |
          if(chain!=nil&&chain.strike!=nil)
            chain.strike.to_f
          end  
        }

        arrayBack = backChains.collect{ | chain |
          if(chain!=nil&&chain.strike!=nil)
            chain.strike.to_f
          end  
        }

        stock  = StockDaily.first(:symbol=>e.symbol)
        if(stock!=nil&&stock.price!=nil)
          strike1 = arrayFront.closest stock.price.to_f
          impliedVolatilities = Array.new
          impliedVolatilities2 = Array.new

          frontChains.each{ | chain |
            if(chain.strike.to_f==strike1)
              puts 'calculating  ' + chain.symbol
              impliedVolatilities << chain.ivolatility.to_f
              puts impliedVolatilities.mean
            end  
          }

          backChains.each{ | chain |
            if(chain.strike.to_f==strike1)
              puts 'calculating2  ' + chain.symbol
              impliedVolatilities2 << chain.ivolatility.to_f
              puts impliedVolatilities2.mean
            end  
          } 
          if(impliedVolatilities.mean!='NaN')
            e.frontMonth = "%0.2f" % (impliedVolatilities.mean*100)
          end
          if(impliedVolatilities2.mean!='NaN')
            e.backMonth = "%0.2f" % (impliedVolatilities2.mean*100)
          end
        end
      end
      e.save
    }
    return indexes
  end
  
  def Index_Etf_report.getChains(chains,osymbol)
    chainsA = Array.new
    chains.each{|chain|
     if (chain.symbol.include? osymbol)
       puts chain.symbol
       chainsA << chain
     end
    }
    chainsA
  end
  

end
