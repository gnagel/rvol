require 'math/arraymath'
#
# A report with different standard deviation spikes.
#
class Sdreport
  #
  # load tickers
  #
  def loadTickers
    puts 'loading report'
    date = Time.now
    past = 60*60*24*30
    twentyago = date - past
      stock = Stockdaily.new
      stock.symbol='IBM'
      stock.save
      history = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>twentyago)
      arrayPrices = history.collect{|tic| tic.close.to_f }
      stock.std20 = arrayPrices.stdev
      puts arrayPrices.stdev
      stock.save
  end
end