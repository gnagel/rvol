require 'model/stockcorrelation'
require 'statsample'
require 'peach'
require 'monitor'
#
# Calculate correlations. This class calculates correlations for all instruments
# in a given set.
#
class Calculatecorrelations < Monitor

  #
  #  Calculate correlations for stocs in the same industry groups
  #
  def calculateYearlyCorrelationRF
      startTime = Time.now
      processed = Array.new
      tickrs = Ticker.all(:indexName=>'SP500')
      tickrs2 = Array.new(tickrs)
      # half year correlation
      days = DateTime.now-175
      arrayPrices = Stockhistorical.all(:date.gt=>days,:order =>[:date.asc])
      # for each ticker
      tickrs.each do |tickr|
        processed << tickr.symbol
        # get all history for the given ticker
        arrayPricesSymbol  =  arrayPrices.find_all{|hist| hist.symbol == tickr.symbol}.collect { |tickra| tickra.close.to_f }
        arrayPricesSymbol = arrayPricesSymbol.to_scale

        tickrs2.peach do |tickr2|
          # only in the same industry
          if (tickr.industry == tickr2.industry)
            begin
              if (tickr != tickr2&&!processed.include?(tickr2.symbol))
                arrayPricesSymbol2 =  arrayPrices.find_all{|hist| hist.symbol == tickr2.symbol}.collect { |tickr2a| tickr2a.close.to_f }
                arrayPricesSymbol2 = arrayPricesSymbol2.to_scale
                #ycorrelation = arrayPricesSymbol.correlation(arrayPricesSymbol2)
                ycorrelation = Statsample::Bivariate.pearson(arrayPricesSymbol,arrayPricesSymbol2)
                puts " #{tickr.symbol} AND #{tickr2.symbol} CORRELATION #{ycorrelation}"
                delta = calculateDelta2(arrayPricesSymbol, arrayPricesSymbol2)
                puts "DELTA for #{tickr.symbol} AND #{tickr2.symbol}: #{delta}"

                saveCorrelation(tickr, tickr2, ycorrelation,delta,175,tickr.industry)
              end
            rescue => error
                puts "Correlation calcuation failed for #{tickr.symbol} AND #{tickr2.symbol}!"
                puts error
            end
          end
        end
      end
      endTime = Time.now

      puts 'Correlation calculation:'
      puts "Time elapsed #{(endTime - startTime)} seconds"
  end

  def calculateDelta2(arrayPricesSymbol, arrayPricesSymbol2)
    arrayRatio = Array.new
    for i in 0..arrayPricesSymbol.size-1
      arrayRatio << arrayPricesSymbol[i] / arrayPricesSymbol2[i]
    end

    delta = arrayRatio.to_scale.sd
  end

  #
  #  Calculate correlations for stocs in the same industry groups
  #
  def calculateCurrentCorrelation(days)
    processed = Array.new
    tickrs = Ticker.all(:indexName=>'SP500')
    tickrs2 = Array.new(tickrs)
    daysNoWeekends = (days / 5)*2 + days + 1
    arrayPrices = Stockhistorical.all(:date.gt=>DateTime.now-daysNoWeekends,:order =>[:date.asc])

    # for each ticker
    tickrs.each do |tickr|
      processed << tickr.symbol
      # get all history for the given ticker
     arrayPricesSymbol  =  arrayPrices.find_all{|hist| hist.symbol == tickr.symbol}.collect { |tickra| tickra.close.to_f }
     arrayPricesSymbol = arrayPricesSymbol.to_scale
      tickrs2.peach do |tickr2|
        # only in the same industry
        if (tickr.industry == tickr2.industry)
          begin
            if (tickr != tickr2&&!processed.include?(tickr2.symbol)&&tickr.industry==tickr2.industry)
              arrayPricesSymbol2 = arrayPrices.find_all{|hist| hist.symbol == tickr2.symbol}.collect { |tickr2a| tickr2a.close.to_f }
              arrayPricesSymbol2 = arrayPricesSymbol2.to_scale
              #ycorrelation = arrayPricesSymbol.correlation(arrayPricesSymbol2)
              ycorrelation = Statsample::Bivariate.pearson(arrayPricesSymbol,arrayPricesSymbol2)
              delta = calculateDelta2(arrayPricesSymbol, arrayPricesSymbol2)

              puts " #{tickr.symbol} AND #{tickr2.symbol} CORRELATION #{days} #{ycorrelation}"
              puts "DELTA for #{tickr.symbol} AND #{tickr2.symbol}: #{delta}"

              saveCorrelation(tickr, tickr2, ycorrelation,delta,days,tickr.industry)
            end
              rescue => error
                      puts 'Correlation calcuation failed!'
                      puts error
          end
        end
      end
    end
  end

  #
  # Get a list of stocks where the correlation is not in synch with the long term correlation
  #
  def getCorrelationIrregularity

     higlyCorrelatedStocks175 = Stockcorrelation.all(:days=>175,:correlation.gt => 0.98)
     puts "found this many highly correlated stocks:  #{higlyCorrelatedStocks175.size}"
     matches = Array.new
     higlyCorrelatedStocks175.each do |highcor|
        matches += Stockcorrelation.all(:symbol=>highcor.symbol,:symbol2=>highcor.symbol2,:days=>10,:correlation.lt => 0.3)
     end
    return matches
  end

  #
  # Get a list of highly correlated stocks
  #
  def getCorrelatedStocks(symbol)
    correlated = Stockcorrelation.all(:symbol=>symbol,:days=>175,:correlation.gt => 0.97) + Stockcorrelation.all(:symbol2=>symbol,:days=>175,:correlation.gt => 0.97)
  end


  def cleanCorrelation10
    Stockcorrelation.all(:days=>20).destroy
  end

  #
  #Calculate the ratio of the pair
  #
  def calculatePriceRatio

  end

  # Calculate the delta of the pair for the past 10 days.
  def calculateDelta(symbol1,symbol2,days)
    daysNoWeekends = (days / 5) * 2 + days+1
    arrayPrices1   = Stockhistorical.all(:symbol=>symbol1,:date.gt=>DateTime.now-daysNoWeekends,:order =>[:date.asc])
    arrayPrices2   = Stockhistorical.all(:symbol=>symbol2,:date.gt=>DateTime.now-daysNoWeekends,:order =>[:date.asc])

    arrayRatio = Array.new

    for i in 0..arrayPrices1.size-1
      arrayRatio << arrayPrices1[i].close.to_f - arrayPrices2[i].close.to_f
    end

    delta = arrayRatio.to_scale.sd
    delta
  end

  #private methods
  private

  def saveCorrelation(tickr, tickr2, ycorrelation,delta,days,industry)
    correlationToSave = Stockcorrelation.new
    correlationToSave.created_at = DateTime.now
    correlationToSave.symbol = tickr.symbol
    correlationToSave.symbol2 = tickr2.symbol
    correlationToSave.correlation = ycorrelation
    correlationToSave.delta = delta
    correlationToSave.industry = industry
    correlationToSave.days = days
    correlationToSave.uniqueid = tickr.symbol+tickr2.symbol+days.to_s
    # synchronized for file access problems with sqllite
    synchronize do
      if correlationToSave.save
      else
        puts 'saving failed'
        correlationToSave.errors.each do |e|
          puts e
        end
      end
    end
  end





end