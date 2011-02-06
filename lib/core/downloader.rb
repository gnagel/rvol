# encoding: utf-8
require 'Rvol'
require "scrapers/historicalscraper"
require "scrapers/stocks"
require "scrapers/optionschainsscraper"
require "scrapers/earningsscraper"
require 'reports/earningsreport'
require 'reports/IndexReport'
require "model/stock"
require "model/chain"
require "model/earning"
require 'dm-core'
require 'dm-migrations'

# This class wraps up all financial data downloads and stores the information into a database.
# Errors are logged for quality of service
# Author:: Toni Karhu
# Copyright:: Copyright (c) Toni Karhu
# :title:MarketDownloader

class Downloader
  # initialize download
  def init
    #DataMapper::Logger.new($stdout, :debug)
    #DataMapper.setup(:default,Rvol.config['snapshot'])
    #DataMapper::Model.raise_on_save_failure = true
    DataMapper.finalize
    DataMapper.auto_migrate!

    self.downloadSP500Tickers
    self.downloadHistorical
    self.createIndexEtfs
    self.downloadSP500stock
    self.downloadSP500Chains
    self.calculateChains
    self.downloadEarnings

  end

  # This will download all S&P 500 data from the internet and
  # store it in a database. Failed reads should be logged for
  # later processing
  def downloadSP500Tickers
    puts 'starting downloadSP500Tickers'
    result = Stocks.new.downloadSP500
    result.each{|ticker|
      begin
        tick = Ticker.new
        tick.created_at = Time.now
        tick.symbol     = ticker
        tick.index      = 'SP500'
        tick.save
      rescue => boom
        puts 'error  ' + ticker
        puts boom
      end
    }
  end

  # Download index data and chains
  # SPY, DIA, IWM, USO , GLD ,QQQQ,
  # Also download volaitlity: VIX , VXX , VXZ
  # Download equities with weeklies
  #
  def createIndexEtfs
    indexes = ['^OEX','^XEO','^DJX','^SPX','EEM','FAZ','FAS','IWM','QQQQ','SPY','XLF','TLT','TBT','SLV']
    #equity = ['AAPL','AMZN','BAC','BIDU','BP','C','CSCO','F','GE','GOOG','GS','MSFT','NFLX','INTC','IBM','PCLN','RIMM']
    oil = ['USO']
    gold = ['GLD','GDX']
    volatility=['^VIX','VXX','VXZ']
    emergingMarkets=['BRF']
    currencies=['UUP']
    etfs = [indexes,oil,gold,volatility,emergingMarkets,currencies]
    etfs.flatten!
    etfs.each{|x|
      tick = Ticker.new
      tick.created_at = Time.now
      tick.symbol     = x
      tick.index      = 'index-etf'
      tick.save
    }

  end

  # This will download all S&P 500 data from the internet and
  # store it in a database. Failed reads should be logged for
  # later processing
  #
  def downloadSP500stock
    puts 'starting downloadSP500Stock'
    result = Ticker.all()
    puts result.size
    sp = Stocks.new.downloadStock2(result.collect{|tic| tic.symbol},true)
  end

  # This will download all chains for the S&P500
  # Names taken from last download
  # Chains should be loaded for the next 2 months
  def downloadSP500Chains
    puts 'starting downloadSP500chains'
    result = Ticker.all()
    OptionChainsScraper.new.loadChains(result.collect{|tic| tic.symbol},true)
  end
  #
  # Calculates the total amount of calls and puts for the front month
  #
  def calculateChains
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
    }
  end

  ##
  # This will download all earnings for the next month
  ##
  def downloadEarnings
    result = Ticker.all(:index => 'SP500')
    EarningsScraper.new.getEarningsMonth2(result.collect{|tic| tic.symbol})
  end
  
  def downloadHistorical
    result = Ticker.all(:index => 'SP500')
    Historicalscraper.downloadHistoricalData(result.collect{|tic| tic.symbol},true)
  end
  
  #
  # Download economic events: Downloads goverment events which will
  # have an effect on the markets
  #
  def downloadEvents
    # tbd
  end

  def printErrors(object)
    object.errors.each do |e|
      puts e
    end
  end

end