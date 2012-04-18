require 'model/stockcorrelation'
require 'statsample'
#
# Calculate correlations
#
class Calculatecorrelations


  def calculateYearlyCorrelationRF
    processed = Array.new
    tickrs = Ticker.all(:index=>'SP500')
    tickrs2 = Array.new(tickrs)
    # half year correlation
    days = DateTime.now-175
    arrayPrices = Stockhistorical.all(:date.gt=>days,:order =>[:date.asc])
    # for each ticker
    tickrs.each do |tickr|
      processed << tickr.symbol
      # get all history for the given ticker
      arrayPricesSymbol  =  arrayPrices.find_all{|hist| hist.symbol == tickr.symbol}.collect { |tickr| tickr.close.to_f }
      arrayPricesSymbol = arrayPricesSymbol.to_scale

      tickrs2.each do |tickr2|
          begin
            if (tickr != tickr2&&!processed.include?(tickr2.symbol))
              arrayPricesSymbol2 =  arrayPrices.find_all{|hist| hist.symbol == tickr2.symbol}.collect { |tickr2| tickr2.close.to_f }
              arrayPricesSymbol2 = arrayPricesSymbol2.to_scale
              #ycorrelation = arrayPricesSymbol.correlation(arrayPricesSymbol2)
              ycorrelation = Statsample::Bivariate.pearson(arrayPricesSymbol,arrayPricesSymbol2)
              puts " #{tickr.symbol} AND #{tickr2.symbol} CORRELATION #{ycorrelation}"
              saveCorrelation(tickr, tickr2, ycorrelation,175)
            end
              rescue => error
                      puts "Correlation calcuation failed for #{tickr.symbol} AND #{tickr2.symbol}!"
                      puts error
          end
      end
    end
  end




  #
  #  Calculate correlations
  #
  def calculateCurrentCorrelation(days)
    processed = Array.new
    tickrs = Ticker.all(:index=>'SP500')
    tickrs2 = Array.new(tickrs)
    daysNoWeekends = (days / 5)*2 + days - 1
    puts daysNoWeekends
    arrayPrices = Stockhistorical.all(:date.gt=>DateTime.now-daysNoWeekends,:order =>[:date.asc])

    # for each ticker
    tickrs.each do |tickr|
      processed << tickr.symbol
      # get all history for the given ticker
     arrayPricesSymbol  =  arrayPrices.find_all{|hist| hist.symbol == tickr.symbol}.collect { |tickr| tickr.close.to_f }
     arrayPricesSymbol = arrayPricesSymbol.to_scale
      tickrs2.each do |tickr2|
          begin
            if (tickr != tickr2&&!processed.include?(tickr2.symbol))
              arrayPricesSymbol2 = arrayPrices.find_all{|hist| hist.symbol == tickr2.symbol}.collect { |tickr2| tickr2.close.to_f }
              arrayPricesSymbol2 = arrayPricesSymbol2.to_scale
              #ycorrelation = arrayPricesSymbol.correlation(arrayPricesSymbol2)
              ycorrelation = Statsample::Bivariate.pearson(arrayPricesSymbol,arrayPricesSymbol2)
              puts " #{tickr.symbol} AND #{tickr2.symbol} CORRELATION #{days} #{ycorrelation}"
              saveCorrelation(tickr, tickr2, ycorrelation,days)
            end
              rescue => error
                      puts 'Correlation calcuation failed!'
                      puts error
          end
      end
    end
  end

  #,:limit=>20
  def getCorrelationIrregularity
     puts 'in here'
     higlyCorrelatedStocks175 = Stockcorrelation.all(:days=>175,:correlation.gt => 0.98)
     puts higlyCorrelatedStocks175.size
     # for each of these find stocks from the 10 day correlations where correlation is low
     higlyCorrelatedStocks14 = Stockcorrelation.all(:days=>14,:order =>[:correlation.asc])
     matches = Array.new
     higlyCorrelatedStocks175.each do |highcor|
        matches += Stockcorrelation.all(:symbol=>highcor.symbol,:symbol2=>highcor.symbol2,:days=>14)
     end

     i = 0
     matches.each do |cor|
          i+=1
          puts cor.symbol
          puts cor.symbol2
          puts cor.correlation
       if i==20
        break
       end
    end
  end


  #private methods
  private

  def saveCorrelation(tickr, tickr2, ycorrelation,days)
    correlationToSave = Stockcorrelation.new
    correlationToSave.created_at = DateTime.now
    correlationToSave.symbol = tickr.symbol
    correlationToSave.symbol2 = tickr2.symbol
    correlationToSave.correlation = ycorrelation
    correlationToSave.days = days
    if correlationToSave.save
    else
      puts 'saving failed'
      correlationToSave.errors.each do |e|
        puts e
      end
    end
  end



end