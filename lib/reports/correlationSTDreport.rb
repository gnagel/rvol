require 'model/stockcorrelation'

#
# calculates correlations for the past 20 days and stores all into db. The idea is to laod std 20 for each 
# correlation to find instruments where correlation has changed
#
class CorrelationSTDreport
  def calculateCorrelations
    puts 'loading report'
    date = Time.now
    # 60s * 60  * 24 * 30  = 30 days = 20 trading days
    past = 60*60*24*30
    oneday = 60*60*24
    twentyago = date - past
    # load all etfs
    tickers = Ticker.all(:index=>'etf')
    puts tickers.size
    tickers2 = Array.new(tickers)
    for i in 0..19 do
      days = oneday*i
      tickers.each do |ticker|
        # TODO sort by date
        history = Stockhistorical.all(:symbol => ticker.symbol ,:date.gt=>twentyago-days,:date.lt=>date-days)
        puts history
        arrayPrices = history.collect{|tic| tic.close.to_f }
        tickers2.each do |ticker2|
          history2 = Stockhistorical.all(:symbol => ticker2.symbol ,:date.gt=>twentyago-days,:date.lt=>date-days)
          puts history2
          arrayPrices2 = history2.collect{|tic| tic.close.to_f }
          correlation = arrayPrices.correlation(arrayPrices2)
          if ticker.symbol != ticker2.symbol
            scorrelation = Stockcorrelation.new
            scorrelation.created_at = (date-days)
            scorrelation.symbol = ticker.symbol
            scorrelation.symbol2 = ticker2.symbol
            scorrelation.correlation = correlation
            if scorrelation.save
            else
              puts 'Error saving correlation'
              scorrelation.errors.each do |e|
                puts e
              end
            end
          end
          puts 'correlation ' + ticker.symbol + ' AND '+ticker2.symbol+' '+correlation.to_s
        end
      end
    end#end 0..19
  end
  
  def loadAllCorrelations
    correlations = Stockcorrelation.all(:symbol=>'SPY',:symbol2=>'EWJ')
      correlations.each do |cor|
        puts cor.symbol
        puts cor.symbol2
        puts cor.correlation
      end
  end
    
end