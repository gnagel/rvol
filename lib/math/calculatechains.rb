# encoding: utf-8
require 'model/chain'

# encoding: utf-8
#
#  Calculations for options chains
#
class CalculateChains


  #
  # Load all tickers and calculate mean implied volatilities to near ITM options
  #
  def calculateFrontAndBackMonthsMeanIVITM

    tickers = Ticker.all
    tickers.each { |tick|
      ticker = tick.symbol
      osymbol = DateUtil.getOptSymbThisMonth(ticker)
      osymbol2 = DateUtil.getOptSymbNextMonth(ticker)

      frontChains = Chain.all(:symbol.like=>osymbol+'%')
      backChains = Chain.all(:symbol.like=>osymbol2+'%')

      if (frontChains.size!=0&&backChains.size!=0)

        # load all chain strikes
        arrayFront = frontChains.collect { |chain| chain.strike.to_f }
        # gets the closest strike to the price
        stock = Stockdaily.first(:symbol=>tick.symbol)
        closestStrike = arrayFront.closest stock.price.to_f

        impliedVolatilities = getImpliedVolatilities(frontChains, closestStrike)
        impliedVolatilities2 = getImpliedVolatilities(backChains, closestStrike)

        if (impliedVolatilities.mean!='NaN')
          tick.frontMonth = "%0.2f" % (impliedVolatilities.mean)
        end
        if (impliedVolatilities2.mean!='NaN')
          tick.backMonth = "%0.2f" % (impliedVolatilities2.mean)
        end
      end
     tick.save
    }
    return tickers
  end

  #
  # Calculate total chain call put volume for all tickers
  #
  def calculateTotalChains
    tickers = Ticker.all
    i = 1
    tickers.each { |ticker|
      calls = 0
      putsa = 0
      osymbol = DateUtil.getOptSymbThisMonth(ticker.symbol)
      frontChains = Chain.all(:symbol.like=>osymbol+'%')
      frontChains.each { |chain|
        if chain.type == 'C'
          calls += chain.vol
        end
        if chain.type == 'P'
          putsa += chain.vol
        end
      }
      ticker.totalCalls = calls
      ticker.totalPuts = putsa
      ticker.save
    }
  end

  private
  #
  # Returns an array of impied volatilities
  #
  def getImpliedVolatilities(chains, closestStrike)
    array = Array.new
    chains.each { |chain|
      if (chain.strike.to_f==closestStrike.to_f)
        array << chain.ivolatility.to_f
      end
    }
    array
  end


end