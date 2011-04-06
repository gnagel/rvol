# encoding: utf-8
require 'reports/earningsreport'
require 'reports/chainsreport'
require 'reports/indexreport'
require 'reports/sdreport'
require 'reports/ivolatilityreport'
require 'core/cron.rb'
require 'yaml'

#
# Module for all commomns methods used in the system
#
module Rvol
  # All applcation configurations are in this file
  @@config = YAML.load_file File.join(File.dirname(__FILE__),'config.yml')

  # Version
  @@version = IO.readlines(File.join(File.dirname(__FILE__),'../VERSION'))
  # Returns config for use in all sub classes
  def Rvol.config
    @@config
  end

  def version
    @@version
  end
  # default adater for all db action stored in gem home directory
  #snapshot = 'sqlite://' + File.join(ENV['GEM_HOME'],'gems','rvol-'+@@version[0])+'/'+Rvol.config['snapshot']
  if !File.exists?(ENV['HOME']+'/.rvol')
    Dir.mkdir(ENV['HOME']+'/.rvol')
  end
  snapshot = 'sqlite://'+ENV['HOME']+'/.rvol/'+Rvol.config['snapshot']
  DataMapper.setup(:default,snapshot)
  DataMapper.finalize
  DataMapper.auto_upgrade!

  def earningsReport
    EarningsReport.new.generateReport
  end

  def indexReport
    IndexReport.new.generateReport('etf')
  end

  def chainReport(ticker)
    ChainsReport.new.generateReport([ticker])
  end

  def chainReportAll
    ChainsReport.new.generateReportAll
  end

  def chainReportTop10Volume
    ChainsReport.new.generateReportTop10Volume
  end

  def chainReportTop10OpenInt
    ChainsReport.new.generateReportTop10OpenInt
  end

  def chainReportTop10ImpliedVolatility
    ChainsReport.new.generateReportTop10ImpliedVolatility
  end

  def chainReportTop10ChangeInOptionPrice
    ChainsReport.new.generateReportTop10ChangeInOptionPrice
  end

  def chainReportTop10VolCalls
    ChainsReport.new.generateReportTop10Calls
  end

  def chainReportTop10VolPuts
    ChainsReport.new.generateReportTop10Puts
  end

  def reportsdev20
    Sdreport.new.generateReportTop50StandardDeviation
  end

  def reportsdev20Scouter
    Sdreport.new.generateReportTop20StandardDeviationScouter
  end

  def reportScouter
     IvolatilityReport.new.loadStockScouter
  end

  #
  # Run the downloader. Downloads all daily data
  #
  def runSnapShot
    down = Downloader.new.initEarningsAndChains
  end

    #
  # Run the downloader. Downloads all daily data
  #
  def runSnapShotHistorical
    down = Downloader.new.initHistoricalAndCorrelations
  end

  #
  # Run daily download with a cron job at 17:00 on every weekday
  #
  def runCron
    Cron.new.run
  end

end