require "model/stockhistorical"
#
# Calculates all std (Standard deviations)
#
class CalculateStd
  #
  # Calculates all std (Standard deviations) for stock held in the database.
  #
  def calculateStd
    date = Time.now
    # 60s * 60  * 24 * 30  = 30 days = 20 trading days
    past = 60*60*24*30
    # 60s * 60  * 24 * 7  = 7 days = 5 trading days
    past5 = 60*60*24*7
    twentyago = date - past
    fiveago = date - past5
    i = 0
    Stockdaily.all.each do |stock|
      begin
      history20 = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>twentyago)
      history5 = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>fiveago)
      arrayPrices = history20.collect{|tic| tic.close.to_f }
      arrayPrices2 = history5.collect{|tic| tic.close.to_f }
      stock.std20 = arrayPrices.stdev
      stock.std5 = arrayPrices2.stdev
      i+=1
      puts i.to_s+ ' STD 20 day and 5 day for '+stock.symbol.to_s+' '+  stock.std20.to_s + 'STD 5'+  stock.std5.to_s
      stock.save
      rescue => e
        puts 'calculateStd failed '+e.to_s
      end
    end
  end

end