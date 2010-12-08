
require 'reports/earningsreport'
require 'reports/chainsreport'
require 'reports/indexreport'
require 'core/cron.rb'
#
# Module for all commomns methods used in the system
#
module Rfinance
  
  DataMapper.setup(:default, 'sqlite:///Users/tonikarhu/Development/rfinance/data/markettoday.db') 
  
  def earningsReport
    EarningsReport.new.generateReport
  end
  
  def indexReport
    IndexReport.new.generateReport
  end
  
  def chainReport(ticker)
    ChainsReport.new.generateReport([ticker])
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