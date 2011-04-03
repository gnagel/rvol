# encoding: utf-8
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'
require 'reports/reportprinter'

class IndexReport
  def generateReport(index)
    data = loadData(index)
    puts 'EBUGGING!'
    puts data
    ReportPrinter.new.printIndexReport(data);
  end

  #
  # Load index stocks and calcualte chains
  #
  def loadData(index)

    indexes = Ticker.all(:index=>index)

    indexes.each{|e|

      ticker      = e.symbol
      osymbol     = DateUtil.getOptSymbThisMonth(ticker)
      osymbol2     = DateUtil.getOptSymbNextMonth(ticker)

      frontChains = Chain.all(:symbol.like=>osymbol+'%')
      backChains = Chain.all(:symbol.like=>osymbol2+'%')

      if(frontChains.size!=0&&backChains.size!=0)

        # load all chain strikes
        arrayFront = frontChains.collect{|chain|chain.strike.to_f}
        # gets the closest strike to the price
        stock  = Stockdaily.first(:symbol=>e.symbol)
        closestStrike = arrayFront.closest stock.price.to_f

        impliedVolatilities = getImpliedVolatilities(frontChains,closestStrike)
        impliedVolatilities2 = getImpliedVolatilities(backChains,closestStrike)

        if(impliedVolatilities.mean!='NaN')
          e.frontMonth = "%0.2f" % (impliedVolatilities.mean)
        end
        if(impliedVolatilities2.mean!='NaN')
          e.backMonth = "%0.2f" % (impliedVolatilities2.mean)
        end
      end

      if e.save
      else
        e.errors.each do |es|
          puts es
        end
      end

    }
   indexes
  end

  #
  # Returns an array of impied volatilities
  #
  def getImpliedVolatilities(chains,closestStrike)
    array = Array.new
    chains.each{|chain|
      if(chain.strike.to_f==closestStrike.to_f)
        array << chain.ivolatility.to_f
      end
    }
    array
  end

end
