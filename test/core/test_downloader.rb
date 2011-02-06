# encoding: utf-8
require 'helper'
require 'core/downloader'
require "scrapers/stocks"
require "scrapers/optionschainsscraper"
require "scrapers/earningsscraper"
require "model/stock"
require 'reports/earningsreport'
require 'reports/IndexReport'
require 'test/unit'

class TestDownloader < Test::Unit::TestCase
  # This class wraps up all financial data downloads and stores the information into a database.
  # Errors are logged for quality of service
  # Author:: Toni Karhu
  # Copyright:: Copyright (c) Toni Karhu
  # :title:MarketDownloader
  # initialize download
  def test_Init
    # initialise Downloader used to detect errors in conf
    d = Downloader.new
    begin

      self.createIndexEtfs
      self.downloadSP500stock
      self.downloadSP500Chains
      self.downloadEarnings
      self.doCalculations
    rescue => boom
      flunk('test downloader failed! ' + boom.message)
    end

  end

  # Download index data and chains
  # SPY, DIA, IWM, USO , GLD ,QQQQ,
  # Also download volaitlity: VIX , VXX , VXZ
  # Download equities with weeklies
  #
  def createIndexEtfs

    emergingMarkets=['BRF','IWM','^VIX']
    etfs = [emergingMarkets]
    etfs.flatten!
    etfs.each{|x|
      tick = Ticker.new
      tick.created_at = Time.now
      tick.symbol     = x
      tick.index      = 'index-etf'
      tick.save
    }

    assert_equal(Ticker.all().size,3)

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
    result = Ticker.all(:index => 'index-etf')
    puts result.size
    OptionChainsScraper.new.loadChains(result.collect{|tic| tic.symbol},true)
  end

  ##
  # This will download all earnings for the next month
  ##
  def downloadEarnings
    result = Ticker.all(:index => 'index-etf')
    EarningsScraper.new.getEarningsMonth2(result.collect{|tic| tic.symbol})
  end

  #
  # Download economic events: Downloads goverment events which will
  # have an effect on the markets
  #
  def downloadEvents
    # tbd
  end

  #
  # Preprocess data for reports
  #
  def doCalculations
    ## earnings fron and back month calc
    EarningsReport.new.loadData
    IndexReport.new.loadData
  end

  def printErrors(object)
    object.errors.each do |e|
      puts e
    end
  end

end