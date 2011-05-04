# encoding: utf-8
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
      table << [elem.type, elem.ticker, elem.date.strftime("%d"), elem.strike, elem.symbol, elem.last, elem.chg, elem.bid, elem.ask,
                elem.vol, elem.openInt, checkIVol(elem.ivolatility)]
    }
    print table
    puts addVol(chains)
    puts addOpenInt(chains)
  end

  #
  # Prints the chains for a single month and single ticker
  #
  def printChainsReportSingle(chains, stock)
    tableHead = Table(%w[Name Symbol Price AverageVolume Volume DividendsDate])
    tableHead << [stock.name, stock.symbol, stock.price, stock.avolume, stock.volume, stock.exdividenddate]
    table = Table(%w[Type Ticker ExpiryIn Strike Symbol Last Chg Bid Ask Vol openInt ImpliedVolatility])
    chains.each { |elem|
      table << [elem.type, elem.ticker, elem.date.strftime("%d"), elem.strike, elem.symbol, elem.last, elem.chg, elem.bid, elem.ask,
                elem.vol, elem.openInt, checkIVol(elem.ivolatility)]
    }
    print tableHead
    print table
    puts addVol(chains)
    puts addOpenInt(chains)
  end

  #
  # Prints the top 10 calls or puts volume for today
  #
  def printTop10OptionsVolReport(tickers)
    table = Table(%w[Symbol FrontMonth BackMonth TotalCalls TotalPuts])
    tickers.each { |ticker|
      table << [ticker.symbol, checkIVol(ticker.frontMonth), checkIVol(ticker.backMonth), ticker.totalCalls, ticker.totalPuts]
    }
    print table
  end

  #
  # Prints the earnings report for next month
  #
  def printEarningsReport(earnings)
    table = Table(%w[Date Ticker Company Price ImpliedVolatility1 Impliedvolatility2 Difference avVolume])
    earnings.sort { |a, b| a.date <=> b.date }.each { |elem|
      begin
        difference = elem.frontMonth-elem.backMonth
      rescue
      end
      stock = Stockdaily.first(:symbol=>elem.ticker)
      table << [elem.date, elem.ticker, stock.name, stock.price, checkIVol(elem.frontMonth), checkIVol(elem.backMonth), checkValue(difference), stock.avolume]
    }
    print table
  end

    #
  # Prints the earnings report for next month
  #
  def printDividendsReport(dividends)
    table = Table(%w[DivDate Ticker Company Price avVolume])
    dividends.sort { |a, b| a.exdividenddate <=> b.exdividenddate }.each { |elem|
      begin
        difference = elem.frontMonth-elem.backMonth
      rescue
      end
      table << [elem.exdividenddate, elem.symbol, elem.name, elem.price, elem.avolume]
    }
    print table
  end

  #
  # Prints the  index report
  #
  def printIndexReport(indexes)
    table = Table(%w[Ticker Index Price impliedVolatility1 impliedvolatility2 difference])
    indexes.each { |elem|
      begin
        difference = elem.frontMonth-elem.backMonth
      rescue
      end
      stock = Stockdaily.first(:symbol=>elem.symbol)
      if (stock!=nil)
        name = stock.name
        price = stock.price
      end
      table << [elem.symbol, name, price, checkIVol(elem.frontMonth), checkIVol(elem.backMonth), checkValue(difference)]
    }
    print table
  end

  def printTop50SdevReport(tickers)
    table = Table(%w[Symbol Name Price AverageVolume Volume StandardDeviation20])
    tickers.each { |stock|
      table <<[stock.symbol, stock.name, stock.price, stock.avolume, stock.volume, stock.std20]
    }
    print table
  end

  def printScouterStd(tickers)
    table = Table(%w[Symbol Name Price AverageVolume Volume StandardDeviation20])
    tickers.each { |stock|
      table <<[stock.symbol, stock.name, stock.price, stock.avolume, stock.volume, stock.std20]
    }
    print table.sort_rows_by("StandardDeviation20",:order => :descending)
  end

  #
  # return empty value
  #
  def checkIVol(value)
    begin
      value = value.to_f
      if (value<0)
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
    summable = chains.each { |x|
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
    summable2 = chains.each { |x|
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