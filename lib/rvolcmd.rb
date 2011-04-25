# encoding: utf-8
require 'optparse'
require 'optparse/time'
require 'ostruct'

autoload :Rvol, 'Rvol'

#
# Main class for accessing the application. Commands can be entered from
# here with the option parser. Implementations methods are grouped at the bottom.

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
      cmd = Rvolcmd.new
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: rvol [options]
        
        run rvol -s to download a market snapshot after this you can view all of the reports (download 20-30 minutes do only once). 
        
        Some Examples:

          1. rvol -p , print all reports available
          2. rvol -s , rvol -r EarningsReport , for coming earnings report with volatilities
          3. rvol -c AAPL , for an instant report on a stock (realtime not from snapshot)"

        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-p", "--printreports", "Print all available reports") do
          cmd.printReports
        end

        opts.on("-r", "--report [REPORT]", "Print the given report use rvol -p to get a list of reports") do |report|
          cmd.runReport(report)
        end

        opts.on("-c", "--chainReport [TICKER]", "Show basic into and list chains for ticker report") do |ticker|
          cmd.chainReport(ticker)
        end

        opts.on("-i", "--indexReport [INDEX]", "Show basic into and list chains for ticker report") do |index|
          cmd.indexReport(index)
        end

        opts.on("-t", "--test", "Used for testing") do
          cmd.test
        end

        opts.on("-s", "--snapshot [type]", "Download market snapshot, type can be either snapshot or historical") do |type|
          puts 'this will take 2 hours the first time about 30 minutes after that'
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
        opts.on("", "--downloader", "start cron type timer downloader, will run 5:00 PM every weekday") do
          cmd.runCron
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
      end

      opts.parse(args)
    rescue => e
      puts e.message.capitalize + "\n\n"
      puts opts
      exit 1
    end
    options
  end # parse()
end # class rvolcmd

