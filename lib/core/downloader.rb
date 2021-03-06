# encoding: utf-8
require 'rvol'
require "scrapers/historicalscraper"
require "scrapers/stocks"
require "scrapers/optionschainsscraper"
require "scrapers/earningsparser"
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

        self.downloadSP500Tickers
        self.downloadEtfTopVol100
        self.downloadstockdetails
        self.downloadSChains
        self.downloadHistorical
        self.calculateStd
        self.calculateFronAndBackMonth
        self.downloadEarnings
        self.calculateTotalChains
  end

  def calculateCorrelations
    puts 'starting calculate corrrelations All'
    Calculatecorrelations.new.calculateYearlyCorrelationRF
  end

  def calculateCorrelations10
    puts 'starting calculate corrrelations 10'
    calc = Calculatecorrelations.new
    calc.cleanCorrelation10
    calc.calculateCurrentCorrelation(10)
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

  # This will download all S&P 500 tickers from the internet and
  # store it in a database. Failed reads should be logged for
  # later processing
  def downloadSP500Tickers
    puts 'starting download SP500 tickers'
    yahooDownloader = Stocks.new
    yahooDownloader.downloadSP500
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
    OptionChainsScraper.new.loadChains(Ticker.all(), true)
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
    EarningsScraper.new.getEarningsMonth2(false)
  end

  def downloadHistorical
    puts 'starting download historical'
    Stockhistorical.destroy!
    stocks = Stockdaily.all
    Historicalscraper.new.downloadHistoricalData(stocks, true)
  end

  def downloadStockscouterStocks
    puts 'starting download best and worst stockscouter tickers'
    Stockscouter.new.parseScouterTop10
    Stockscouter.new.parseScouterTop1
    #Stockscouter.new.parseScouterTop50
  end

  def downloadEtfTopVol100
    puts 'starting download top Vol ETF:s'
    Etf.new.parse100TopVolEtf
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