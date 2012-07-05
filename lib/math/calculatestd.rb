require 'model/stockhistorical'
require 'peach'
require 'monitor'
require 'statsample'
#
# Calculates all std (Standard deviations)
#
class CalculateStd < Monitor
  #
  # Calculates all std (Standard deviations) for stock held in the database.
  #
  def calculateStd
    twentyago = DateTime.now - 24
    fiveago = DateTime.now - 7
    i = 0
    Stockdaily.all.peach do |stock|
      begin
      history20 = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>twentyago)
      history5 = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>fiveago)
      arrayPrices = history20.collect{|tic| tic.close.to_f }
      arrayPrices2 = history5.collect{|tic| tic.close.to_f }
      # calcualte the std for the stock
      stock.std20 = arrayPrices.to_scale.sd
      stock.std5 = arrayPrices2.to_scale.sd
      i+=1
      puts i.to_s+ ' STD 20 day and 5 day for '+stock.symbol.to_s+' '+  stock.std20.to_s + ' STD 5 '+  stock.std5.to_s
      # synchronized for file access problems with sqllite
      synchronize do
        stock.save
      end
      rescue => e
        puts 'calculateStd failed '+e.to_s
      end
    end
  end

end