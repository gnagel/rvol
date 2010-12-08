$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'rufus/scheduler'
require 'core/downloader'

#
# Scheduler whitch runs the downloader daily 17:00
#
class Cron
  def runDownloader
    down = Downloader.new
    down.init
  end
  #
  # starts the scheduler
  #
  def run
    puts '**************Daily downloader started***************************'
    scheduler = Rufus::Scheduler.start_new
    # run at 17:00 every day
    scheduler.cron '* 17 * * 1-5',:blocking => true do
      puts '************running daily download***************************'
      c = Cron.new
      c.runDownloader
      puts '************done running daily download**********************'
    end
    scheduler.join
  end

end
