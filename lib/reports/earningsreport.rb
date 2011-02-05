# encoding: utf-8
require 'reports/reportprinter'
require 'math/arraymath'
require 'model/earning'
require 'model/chain'
require 'ruport'

#
# This class holds the items needed for the earnings report
# The report can be printed on the command line or output as a pdf.
#
class EarningsReport
  def generateReport
    ReportPrinter.new.printEarningsReport(loadData)
  end

  #
  # Load earnings tickers and attach chains to them
  #
  def loadData

    earnings = Earning.all
    earnings.each{|e|

      ticker      = e.ticker
      osymbol     = DateUtil.getOptSymbThisMonth(ticker)
      osymbol2    = DateUtil.getOptSymbNextMonth(ticker)

      frontChains = Chain.all(:symbol.like=>osymbol+'%')
      backChains = Chain.all(:symbol.like=>osymbol2+'%')

      if(frontChains.size!=0&&backChains.size!=0)

        # load all chain strikes
        arrayFront = frontChains.collect{|chain|chain.strike.to_f}
        # gets the closest strike to the price
        stock  = StockDaily.first(:symbol=>e.ticker)
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

    }
    return earnings
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
