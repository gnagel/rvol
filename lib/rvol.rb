# encoding: utf-8
require 'reports/report'
require 'core/cron.rb'
require 'yaml'
require 'scrapers/rss'
require 'dm-core'
require 'dm-migrations'
require 'dm-do-adapter'
#
# Module for all commomns methods used in the system
#
module Rvol
  # All applcation configurations are in this file
  @@config = YAML.load_file File.join(File.dirname(__FILE__), 'config.yml')

  # Version
  @@version = IO.readlines(File.join(File.dirname(__FILE__), '../VERSION'))

  def version
    @@version
  end

  def appHome
    File.join(ENV['GEM_HOME'], 'gems', 'rvol-'+@@version[0])
  end

  # default adater for all db action stored in gem home directory
  #snapshot = 'sqlite://' + File.join(ENV['GEM_HOME'],'gems','rvol-'+@@version[0])+'/'+@@config['snapshot']
  # make a fodler for rvol
  if !File.exists?(ENV['HOME']+'/.rvol')
    Dir.mkdir(ENV['HOME']+'/.rvol')
  end

  # If you want the logs displayed you have to do this before the call to setup
  #DataMapper::Logger.new($stdout, :Error)


  ################Database setup ##############################
  # if envinronmental variable RVOL_DB = mysql then use mysql #
  # else use the sqllite database in the home folder.         #
  #############################################################
  # sql lite filename
  @@database = 'sqlite://'+ENV['HOME']+'/.rvol/'+@@config['snapshot']

  # Mysql Database setup if RVOL_DB=mysql set and
  # database rvol_main is there
  if ENV['RVOL_DB'] == 'mysql'
    @@database = @@config['rvol_main']
  end

  DataMapper.setup(:default, @@database)

  # destroy old database and create new
  def clean
    ## delete whole sqllite database
    #file = ENV['HOME']+'/.rvol/'+@@config['snapshot']
    #if File.exist?(file)
    #    File.delete(file)
    #    file.close
    #end

    puts 'CREATING data-snapshot DATABASE'
    ################Database setup #####################
    begin

    DataMapper.setup(:default, @@database)
    DataMapper.finalize
    # Automatically create the tables if they don't exist
    DataMapper.auto_migrate!

    rescue => e
        puts "error with creating a new database: #{@@database}"
        puts e
    end
  end

  def runReport(reportName,arg=nil)
    puts 'Report name: '+ reportName
    begin
      report = Kernel.const_get(reportName).new
    rescue => e
      puts 'report generation failed check the name with rvol -p'
      #puts e
    end
    report.printInfo
    if(arg==nil)
    report.generateReport
    else
     report.generateReportArgs(arg)
    end

  end

  def printReports
    Report.new.printAllReports
  end

  def chainReport(ticker)
    ChainsReport.new.generateReportArgs(ticker)
  end

  def indexReport(index)
    IndexReport.new.generateReport(index)
  end

  #
  # Run the downloader. Downloads all daily data
  #
  def runSnapShot
    down = Downloader.new.initEarningsAndChains
  end
  #
  # Evaluate the ticker from market info
  #
  def evaluate(tickers)
    puts tickers
    aticks = tickers.split(',')
  end

  #
  # Load the news from google finance for a ticker
  #
  def news(ticker,number)
    if number.length == 1
       RssScraper.new.opennews(ticker,number[0])
    else
      RssScraper.new.loadRSS(ticker)
    end
  end
  #
  # Run the downloader. Downloads all daily data
  #
  def runSnapShotHistorical
    Downloader.new.downloadHistorical
  end

  def runSnapShotCorrelations
    Calculatecorrelations.new.calculateYearlyCorrelationRF
  end

  def runSnapShotCorrelations10
    puts 'starting calculate corrrelations 20'
    calc = Calculatecorrelations.new
    calc.cleanCorrelation10
    calc.calculateCurrentCorrelation(20)
  end
  #
  # Study
  #
  def study(stock)
     Tools.new.researchStock(stock)
  end

  #
  # Get all correlated stocks
  #
  def correlated(stock)
    begin
      puts "stock correlated with #{stock}"
      if Calculatecorrelations.count == 0
        puts "There are no correlations calculated did you run the rvol --correlationAll"
      end
      stocks = Calculatecorrelations.new.getCorrelatedStocks(stock)

      stocks.each do |cor|
        puts "#{cor.symbol} and  #{cor.symbol2} CORRELATION #{cor.correlation}"
      end
    end
  end

  def getIrregularCorrelation
    matches = Calculatecorrelations.new.getCorrelationIrregularity
    matches.each do |cor|
      puts "#{cor.symbol} and  #{cor.symbol2} CORRELATION #{cor.correlation}"
    end
  end

    #
  # Run a test on whatever
  #
  def testCase
    puts 'im a testcase'
  end

end