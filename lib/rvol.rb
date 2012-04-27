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
  # Returns config for use in all sub classes
  def Rvol.config
    @@config
  end

  def version
    @@version
  end

  def appHome
    File.join(ENV['GEM_HOME'], 'gems', 'rvol-'+@@version[0])
  end

  # default adater for all db action stored in gem home directory
  #snapshot = 'sqlite://' + File.join(ENV['GEM_HOME'],'gems','rvol-'+@@version[0])+'/'+Rvol.config['snapshot']
  if !File.exists?(ENV['HOME']+'/.rvol')
    Dir.mkdir(ENV['HOME']+'/.rvol')
  end

  # If you want the logs displayed you have to do this before the call to setup
  #DataMapper::Logger.new($stdout, :Error)


  ################Database setup #########################
  snapshot = 'sqlite://'+ENV['HOME']+'/.rvol/'+Rvol.config['snapshot']
  mysql = Rvol.config['rvol_main']
  DataMapper.setup(:default, mysql)
  ################ Mysql Database setup ##################

  #mysql = Rvol.config['rvol_main']
  #DataMapper.setup(:mysql, mysql)
  #DataMapper.repository(:mysql) {
  #DataMapper.finalize
  #DataMapper.auto_upgrade!
  #}


  # cleanup old database and create¨
  def clean
      file = ENV['HOME']+'/.rvol/'+Rvol.config['snapshot']
      if File.exist?(file)
        File.delete(file)
      end
      puts 'CREATING data-snapshot DATABASE'
      ################Database setup #########################
      begin
      mysql = Rvol.config['rvol_main']
      DataMapper.setup(:default, mysql)
      DataMapper.finalize
      DataMapper.auto_migrate!

      rescue => e
        puts 'error with creating a new sql lite database: '
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
    Downloader.new.calculateCorrelations
  end

  def runSnapShotCorrelations10
    Downloader.new.calculateCorrelations10
  end
  #
  # Study
  #
  def study(stock)
     Tools.new.researchStock(stock)
  end

  #
  # Run daily download with a cron job at 17:00 on every weekday
  #
  def runCron
    Cron.new.run
  end

    #
  # Run a test on whatever
  #
  def testCorr
    Calculatecorrelations.new.getCorrelationIrregularity
  end

end