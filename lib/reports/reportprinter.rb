require 'math/arraymath'

#
# Prints out various reports
#
class ReportPrinter
  #
  # Prints the chains for a single month
  #
  def printChainsReport(chains)
    table = Table(%w[Type Ticker ExpiryIn Strike Symbol Last Chg Bid Ask Vol openInt ImpliedVolatility])
    chains.each { |elem|
      table << [elem.type, elem.ticker, elem.date.strftime("%d"), elem.strike, elem.symbol,elem.last,elem.chg,elem.bid,elem.ask,
        elem.vol,elem.openInt,checkIVol(elem.ivolatility) ]
    }
    print table
    puts addVol(chains)
    puts addOpenInt(chains)
  end

  #
  # Prints the earnings report for next month
  #
  def printEarningsReport(earnings)
    table = Table(%w[Date Ticker Company Price ImpliedVolatility1 Impliedvolatility2 Difference avVolume])
    earnings.sort { |a,b| a.date <=> b.date }.each { |elem|
      begin
        difference = elem.frontMonth-elem.backMonth
      rescue
      end
      stock = StockDaily.first(:symbol=>elem.ticker)
      table << [elem.date, elem.ticker, stock.name,stock.price, checkIVol(elem.frontMonth), checkIVol(elem.backMonth),checkValue(difference),stock.avolume]
    }
    print table
  end

  #
  # Prints the  index report
  #
  def printIndexReport(indexes)
    table = Table(%w[Ticker Index Price impliedVolatility1 impliedvolatility2 difference])
    indexes.each { | elem |
      begin
        difference = elem.frontMonth-elem.backMonth
      rescue
      end
      stock = StockDaily.first(:symbol=>elem.symbol)
      if(stock!=nil)
        name = stock.name
        price = stock.price
      end
      table << [elem.symbol,name,price, checkIVol(elem.frontMonth), checkIVol(elem.backMonth),checkValue(difference)]
    }
    print table
  end

  #
  # return empty value
  #
  def checkIVol(value)
    begin
      value = value.to_f
      if(value<0)
        return 'N/A'
      end
      return "%0.2f" % (value*100)
    rescue
      return 'N/A'
    end
  end

  #
  # return empty value
  #
  def checkValue(value)
    begin
      return "%0.2f" % (value*100)
    rescue
      return 'N/A'
    end
  end

  #
  # calculate volume together
  #
  def addVol(chains)
    valueC = 0
    valueP = 0
    summable = chains.each{|x|
      if x.type=='C'
        valueC += x.vol
      else
        valueP += x.vol
      end
    }
    puts 'Total Call Vol:    ' + valueC.to_s
    puts 'Total Put Vol:     ' + valueP.to_s
    puts 'Put/Call Vol ratio ' + (valueP.to_f/valueC.to_f).to_s

  end

  #
  # calculate openInt together = put call ratio
  #
  def addOpenInt(chains)
    valueC = 0
    valueP = 0
    summable2 = chains.each{|x|
      if x.type=='C'
        valueC += x.openInt
      else
        valueP += x.openInt
      end

    }
    puts 'Total Calls:   ' + valueC.to_s
    puts 'Total Puts:    ' + valueP.to_s
    puts 'Put/Call ratio ' + (valueP.to_f/valueC.to_f).to_s
  end

end