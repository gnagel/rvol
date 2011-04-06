# encoding: utf-8
require 'optparse'
require 'optparse/time'
require 'ostruct'

autoload :Rvol, 'Rvol'

#
# Main class for accessing the application. Commands can be entered from
# here with the option parser. Implementations methods are grouped at the bottom.
#
class Rvolcmd
  include Rvol

  # This hash will hold all of the options
  # parsed from the command-line by
  # OptionParser.
  options = {}

  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # if nothing in input put -h
    ARGV << "-h" if ARGV.empty?
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.encoding = "utf8"
    begin
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: rvol [options]
        
        run rvol -s to download a market snapshot after this you can view all of the reports (download 20-30 minutes do only once). 
        
        Some Examples:
         
          1. rvol -r AAPL , for an instant report (realtime not from snapshot)
          2. rvol -s , rvol -e , for coming earnings report with volatilities 
          3. rvol -s (if not done already), rvol -d , for 20 largest standard deviation spikes
          4. rvol -s (if not done already), rvol -t IV , for top 10 Implied volatilities in the S&P500"

        opts.separator ""
        opts.separator "Specific options:"
        cmd = Rvolcmd.new
        opts.on("-r", "--chainR [TICKER]", "List chains for ticker report") do |ticker|
          cmd.chainReport(ticker)
        end
        opts.on("-e", "--earningsR", "Generate a table of earnings") do
          cmd.earningsReport
        end
        opts.on("-i", "--indexR", "Generate an index report") do
          cmd.indexReport
        end
        opts.on("-a", "--chains", "List all chains") do
          cmd.chainReportAll
        end
        opts.on("-s", "--snapshot [type]", "Download market snapshot, type can be either snapshot or historical") do |type|
          puts 'this will take 2 hours the first time because the historical db is build about 30 minutes after that'
          case type
            when 'snapshot'
              cmd.runSnapShot
            when 'historical'
              cmd.runSnapShotHistorical
            else
              cmd.runSnapShot
              cmd.runSnapShotHistorical
          end

        end
        opts.on("-c", "--downloader", "start cron type timer downloader, will run 5:00 PM every weekday") do
          cmd.runCron
        end
        opts.on("-d", "--sdeviation20", "List highest 20 day standard deviation movers today") do
          cmd.reportsdev20
        end
        opts.on("--scouter10IV", "List highest implied volatilities in stocks rated 10 ") do
          cmd.reportScouter
        end
        opts.on("--scouter10STD", "List highest implied volatilities in stocks rated 10 ") do
          cmd.reportsdev20Scouter
        end
        opts.on("-t", "--top10List [TYPE]", "List top 10 options with highest Volume , OpenInt, IV ,Change, total calls, or total puts") do |type|
          case type
            when "Volume"
              cmd.chainReportTop10Volume
            when "OpenInt"
              cmd.chainReportTop10OpenInt
            when "IV"
              cmd.chainReportTop10ImpliedVolatility
            when "Change"
              cmd.chainReportTop10ChangeInOptionPrice
            when "Calls"
              cmd.chainReportTop10VolCalls
            when "Puts"
              cmd.chainReportTop10VolPuts
            else
              puts 'you did not specify the type of listing'
          end
        end
        opts.separator ""
        opts.separator "Common options:"
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        # Another typical switch to print the version.
        opts.on_tail("-v", "--version", "Show version") do
          puts 'VERSION: '+cmd.version[0]
          exit
        end
        options = opts
      end
      opts.parse!(args)
    rescue => e
      puts e.message.capitalize + "\n\n"
      puts opts
      exit 1
    end

  end # parse()
end # class rvolcmd

