$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'yaml'
require 'dm-core'
require 'dm-migrations'
require 'model/stock'
require 'model/chain'
require 'model/earning'
require 'Rvol'

class Scratchpad
  #set the test db an in memory db
  DataMapper.setup(:default,Rvol.config['snapshot'])
  DataMapper.auto_upgrade!
  
  tickers = Ticker.all
  i = 1
  tickers.each{|ticker|
    calls = 0
    putsa = 0
    osymbol = DateUtil.getOptSymbThisMonth(ticker.symbol)
    frontChains = Chain.all(:symbol.like=>osymbol+'%')
    frontChains.each{|chain|
      if chain.type == 'C'
        calls += chain.vol
      end
      if chain.type == 'P'
        putsa += chain.vol
      end
    }
    ticker.totalCalls = calls
    ticker.totalPuts = putsa
    ticker.save
    puts osymbol
    puts calls
    puts putsa
  }
  

end