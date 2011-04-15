# encoding: utf-8

require 'reports/report'
require 'core/cron.rb'
require 'yaml'

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

  # default adater for all db action stored in gem home directory
  #snapshot = 'sqlite://' + File.join(ENV['GEM_HOME'],'gems','rvol-'+@@version[0])+'/'+Rvol.config['snapshot']
  if !File.exists?(ENV['HOME']+'/.rvol')
    Dir.mkdir(ENV['HOME']+'/.rvol')
  end
  snapshot = 'sqlite://'+ENV['HOME']+'/.rvol/'+Rvol.config['snapshot']
  DataMapper.setup(:default, snapshot)
  DataMapper.finalize
  DataMapper.auto_upgrade!


  def runReport(reportInfo)
    puts 'report name: '+ reportInfo[0]
    puts reportInfo

    begin
      report = Kernel.const_get(reportInfo[0]).new
    rescue => e
      puts 'report generation failed!'
      puts e
    end
    report.printInfo
    report.generateReport
  end

  def printReports
    Report.new.printAllReports
  end

  def chainReport(ticker)
    ChainsReport.new.generateReportArgs([ticker])
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