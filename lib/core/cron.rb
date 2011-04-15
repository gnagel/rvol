# encoding: utf-8
require 'rufus/scheduler'
require 'core/downloader'

#
# Scheduler whitch runs the downloader daily 17:00
#
class Cron
  def runDownloader
    down = Downloader.new
    down.initEarningsAndChains
    down.initHistoricalAndCorrelations
  end

  #
  # starts the scheduler
  #
  def run
    puts '***Daily downloader started next download will start at 17:00****'
    scheduler = Rufus::Scheduler.start_new
    # run at 17:00 every day
    scheduler.cron '* 17 * * 1-5', :blocking => true do
      puts '************running daily download***************************'
      Cron.new.runDownloader
      puts '************done running daily download**********************'
    end
    scheduler.join
  end

end
