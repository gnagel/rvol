require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'
autoload :Rvol, 'Rvol'


class Rvolcmd2
  include Rvol

  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.library = []
    options.inplace = false
    options.encoding = "utf8"
    options.transfer_type = :auto
    options.verbose = false

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

        opts.on("-c", "--chainReport [TICKER]", "Show basic into and list chains for ticker") do |ticker|
          cmd.chainReport(ticker)
        end

        opts.on("-i", "--indexReport [INDEX]", "Show basic into and list chains for index (-i SP500)") do |index|
          cmd.indexReport(index)
        end

        opts.on("-e", "--eval [tickers]", "Evaluate tickers separated by , (-e AAPL,GOOG)") do
          cmd.evaluate(tickers)
        end


        opts.on("-s", "--snapshot [type]", "Download market snapshot, type can be either snapshot or historical") do |type|
          puts 'this can take 1h the first time about 20m after that depending on your processor,network,hd etc'
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
          options.version = cmd.version[0]
          exit
        end

    # List of arguments.
      opts.on("--report ticker1,ticker2,...", Array, "Example 'list' of arguments") do |list|
        options.list = list
      end


    end

    opts.parse!(args)
    options
  end # parse()

 # class OptparseExample

options = Rvolcmd2.parse(ARGV)
pp options
end