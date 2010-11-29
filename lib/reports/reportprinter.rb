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
        elem.vol,elem.openInt,"%0.2f" % (elem.ivolatility*100)+'%' ]
    }
    print table
  end

  #
  # Prints the earnings report for next month
  #
  def printEarningsReport(earnings)
    table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2 difference])
    earnings.sort { |a,b| a.date <=> b.date }.each { |elem|
      begin
        difference = "%0.2f" %(elem.frontMonth-elem.backMonth)
      rescue
      end
      table << [elem.date, elem.ticker, checkValue(elem.frontMonth), checkValue(elem.backMonth),difference]
    }
    print table
  end

  #
  # Prints the  index report
  #
  def printIndexReport(indexes)
    table = Table(%w[Ticker impliedVolatility1 impliedvolatility2 difference])
    indexes.each { | elem |
      begin
        difference = "%0.2f" %(elem.frontMonth-elem.backMonth)
      rescue
      end
      table << [elem.symbol, checkValue(elem.frontMonth), checkValue(elem.backMonth),difference]
    }
    print table
  end

  #
  # return empty value
  #
  def checkValue(value)
    if(value=='nan'||value==nil)
      return ''
    end
    return value
  end

end