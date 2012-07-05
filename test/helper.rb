# encoding: utf-8
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

puts File.dirname(__FILE__)

DataMapper.setup(:default, "sqlite::memory:")
DataMapper.finalize
DataMapper.auto_migrate!

# GENERATE THE TEST DATABASE FROMINTERNETDATA
puts 'GENERATING TEST DATABASE AND TESTING SCRAPERS'

# check if the database is there :
if (Earning.count==0)

  EarningsScraper.new.getEarningsMonth2(true)

  ticker = ['AAPL', 'LVS','IBM']

  ticker.each { |ticker|

      Ticker.create(:created_at=>Time.now,:symbol=>ticker,:indexName=>'SP500')
  }

  Stocks.new.downloadStock2(ticker, true)
  chains = OptionChainsScraper.new.loadChains(ticker, true)
  Historicalscraper.new.downloadHistoricalData(Stockdaily.all, true)


end
puts '****************************** DONE! Starting testing! ***********************************'
puts '***'
puts '***'
puts '***'

# DONE