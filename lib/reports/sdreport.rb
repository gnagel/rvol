require 'math/arraymath'
#
# A report with different standard deviation spikes.
#
class Sdreport
  #
  # Calculates all std (Standard deviations) for stock held in the database.
  #
  def calculateStd
    puts 'loading report'
    date = Time.now
    # 60s * 60  * 24 * 30  = 30 days = 20 trading days
    past = 60*60*24*30
    twentyago = date - past
    Stockdaily.all.each do |stock|
      history = Stockhistorical.all(:symbol => stock.symbol ,:date.gt=>twentyago)
      arrayPrices = history.collect{|tic| tic.close.to_f }
      stock.std20 = arrayPrices.stdev
      puts 'STD 20 For '+stock.symbol.to_s+' '+ arrayPrices.stdev.to_s
      stock.save
    end
  end
  #
  # Report the chains with the most open interest
  #
  def generateReportTop50StandardDeviation
    tickers = Stockdaily.all(:order => [ :std20.desc ]).first 20
    ReportPrinter.new.printTop50SdevReport(tickers)
  end
  
end