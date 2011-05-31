# encoding: utf-8
require 'Rvol'
require "scrapers/historicalscraper"
require "scrapers/stocks"
require "scrapers/optionschainsscraper"
require "scrapers/earningsparser"
require "scrapers/stockscouter"
require 'reports/earningsreport'
require 'reports/IndexReport'
require 'reports/Sdreport'
require 'reports/correlationSTDreport'
require "model/stock"
require "model/chain"
require "model/earning"
require "model/stockcorrelation"
require 'dm-core'
require 'dm-migrations'
require 'scrapers/etf'
require 'benchmark'
require 'math/calculatestd'
require 'math/calculatechains'
require 'math/calculatecorrelations'

# This class wraps up all financial data downloads and stores the information into a database.
# Errors are logged for quality of service
# Author:: Toni Karhu
# Copyright:: Copyright (c) Toni Karhu
# :title:MarketDownloader

class Downloader
  # initialize download
  def initEarningsAndChains

    DataMapper.finalize
    #DataMapper.auto_migrate!
    DataMapper.auto_upgrade!
    # cleanup database
    self.cleanup

    Benchmark.bm do |x|
      x.report('Downloading: ') {

        self.downloadSP500Tickers
        self.downloadEtfTopVol100
        self.downloadStockscouterStocks
        self.downloadstockdetails
        self.downloadEarnings
        self.downloadSChains
      }
      x.report('Calculating: ') {
        self.calculateFronAndBackMonth
        self.calculateTotalChains

      }
    end
  end

  def initHistoricalAndCorrelations
    Benchmark.bm do |x|
      x.report('Download Historical: ') {
        self.downloadHistorical
      }
      x.report('Calculate standard deviations: ') {
        self.calculateStd }
      x.report('Calculate correlations: ') {
        # skip this for now too slow
        #self.caclulateCorrelations
      }
    end
  end

  #
  # Cleanup the datase
  #
  def cleanup
    puts 'Cleaning up database'
     Ticker.destroy
     Stockdaily.destroy
     Chain.destroy
     Earning.destroy
     Stockcorrelation.destroy
  end

  # This will download all S&P 500 data from the internet and
  # store it in a database. Failed reads should be logged for
  # later processing
  def downloadSP500Tickers
    puts 'starting download SP500 tickers'
    result = Stocks.new.downloadSP500
    result.each { |ticker|
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
  end

  # This will download all S&P 500 data from the internet and
  # store it in a database. Failed reads should be logged for
  # later processing
  #
  def downloadstockdetails
    puts 'starting download SP500 stock details'
    result = Ticker.all()
    puts result.size
    sp = Stocks.new.downloadStock2(result.collect { |tic| tic.symbol }, true)
  end

  # This will download all chains for the S&P500
  # Names taken from last download
  # Chains should be loaded for the next 2 months
  def downloadSChains
    puts 'starting download chains'
    result = Ticker.all()
    OptionChainsScraper.new.loadChains(result.collect { |tic| tic.symbol }, true)
  end

  #
  # Calculates the total amount of calls and puts for the front month
  #
  def calculateFronAndBackMonth
    puts 'starting calculate front and back month for tickers'
    CalculateChains.new.calculateFrontAndBackMonthsMeanIVITM
  end

  #
  # Calculates the total amount of calls and puts for the front month
  #
  def calculateTotalChains
    puts 'starting calculate total chains for all'
    CalculateChains.new.calculateTotalChains
  end

  #
  # Calculate standard deviations
  #
  def calculateStd
    puts 'starting calculate standard deviations'
    CalculateStd.new.calculateStd
  end

  ##
  # This will download all earnings for the next month
  ##
  def downloadEarnings
    puts 'starting download earnings'
    EarningsScraper.new.getEarningsMonth2
  end

  def downloadHistorical
    puts 'starting download historical'
    stocks = Stockdaily.all
    Historicalscraper.new.downloadHistoricalData(stocks, true)
  end

  def downloadStockscouterStocks
    puts 'starting download best and worst stockscouter tickers'
    Stockscouter.new.parseScouterTop10
    Stockscouter.new.parseScouterTop1
    Stockscouter.new.parseScouterTop50
  end

  def downloadEtfTopVol100
    puts 'starting download top Vol ETF:s'
    Etf.new.parse100TopVolEtf
  end

  def caclulateCorrelations
    puts 'starting calculate corrrelations'
    Calculatecorrelations.new.calculateCorrelations
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