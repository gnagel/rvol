require 'reports/earningsreport'
require 'reports/chainsreport'
require 'reports/indexreport'
require 'core/cron.rb'
require 'yaml'

#
# Module for all commomns methods used in the system
#
module Rvol
  # All applcation configurations are in this file
  @@config = YAML.load_file File.join(File.dirname(__FILE__),'config.yml')
  # Returns config for use in all sub classes
  def Rvol.config
    @@config
  end
  # default adater for all db action
  DataMapper.setup(:default,Rvol.config['snapshot'])

  def earningsReport
    EarningsReport.new.generateReport
  end

  def indexReport
    IndexReport.new.generateReport
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

  #
  # Run the downloader. Downloads all daily data
  #
  def runSnapShot
    down = Downloader.new
    down.init
  end

  #
  # Run daily download with a cron job at 17:00 on every weekday
  #
  def runCron
    Cron.new.run
  end

end