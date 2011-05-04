# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'Rvol'
require 'test/unit'
require 'dm-core'
require 'dm-migrations'
require 'model/stock'
require 'model/chain'
require 'model/earning'
require 'model/stockcorrelation'

#set the test db an in memory db
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default,Rvol.config['test'])
DataMapper.finalize
DataMapper.auto_migrate!

# GENERATE THE TEST DATABASE FROMINTERNETDATA
puts 'GENERATING TEST DATABASE'

    EarningsScraper.new.getEarningsMonth2(true)
    ticker = ['AAPL','LVS','GOOG','IBM','SPY']
    ticker.each { |ticker|
      begin
        tick = Ticker.new
        tick.created_at = Time.now
        tick.symbol = ticker
        tick.index = 'SP500'
        tick.save
      rescue => boom
        puts 'error  ' + ticker
        puts boom
      end
    }
    Stocks.new.downloadStock2(ticker,true)
    chains = OptionChainsScraper.new.loadChains(ticker,true)
    Historicalscraper.new.downloadHistoricalData(Stockdaily.all,true)


    CalculateChains.new.calculateFrontAndBackMonthsMeanIVITM
    CalculateStd.new.calculateStd
    CalculateChains.new.calculateTotalChains
    Calculatecorrelations.new.calculateCorrelations


puts 'DONE! Starting testing!'
# DONE