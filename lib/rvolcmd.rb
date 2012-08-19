# encoding: utf-8
# this enables the paths in the dev environment will see what happens in the gem
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'
require 'rufus/scheduler'

autoload :Rvol, 'rvol'
#
# Main class for parsing command line commands
#
class Rvolcmd
  include Rvol
  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    args << "-h" if args.empty?
    options = OpenStruct.new
    options.library = []
    options.inplace = false
    options.encoding = "utf8"
    options.transfer_type = :auto
    options.verbose = false

    opts = OptionParser.new do |opts|

      puts ''
      puts "____________________________________________________________________"
      puts ''
      puts "RVOL version #{@@version}"
      puts "database set to: #{@@database}"
      puts "____________________________________________________________________"
      puts ''

      opts.banner = "Usage: rvol [options]

        run rvol -s to download a market snapshot after this you can view
        all of the reports (download 20-30 minutes do only once).

        Some Examples (download snapshot first):

          1. rvol -p , print all reports available
          2. rvol -r EarningsReport , for coming earnings report with volatilities
          3. rvol -t AAPL , for an instant report on a stock/etf etc (realtime not from snapshot)"


      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-t", "--ticker SYMBOL", "instant report on an instrument") do |symbol|
        options.command = "ticker"
        options.args = symbol
      end

      opts.on("-p", "--printreports", "Print all available reports") do
        options.command = "printreports"
      end

      opts.on("-r", "--report REPORT [ARGS]", "Print the given report use rvol -p to get a list of reports") do |report|
        options.command = "report"
        options.report = report
        options.args = args
      end

      opts.on("-n", "--news TICKER ARGS", "Get a list of latest news for a ticker',' , (-n MCD)") do |ticker|
        options.command = "news"
        options.ticker = ticker
        options.args = args
      end

      opts.on("-s", "--snapshot", "Download market snapshot") do
        puts 'this can take 1h the first time about 20m after that depending on your processor,network,hd etc'
        options.command = "snapshot"
      end

      opts.on("--clean", "Cleanup old database if problems with data storage use this if there are errors with data loading") do |type|
        puts 'deleting old database'
        options.command = "clean"
      end

      opts.on("--correlationAll", "Calculate correlation for all instruments for the past 170 trading days") do
            options.command = "correlationAll"
      end

      opts.on("--correlation10", "Calculate correlation for all instruments for the past 10 trading days") do
            options.command = "correlation10"
      end

      opts.on("--correlated TICKER", "Get a list of correlated instruments (remember to do the --correlationAll first )',' , (--correlated MCD)") do |ticker|
        options.command = "correlated"
        options.ticker = ticker
      end

      opts.on("--history", "load 1 year history for all tickers in system") do
        options.command = "history"
      end

      opts.on("--test", "used for to test a particular usecase") do
        options.command = "test"
      end

      opts.on("--cronjob", "run cron type job every hour at half past") do
        puts '*** MARKETSNAPSHOT SCHEDULER WAITING ***  ' + Time.now.to_s
        scheduler = Rufus::Scheduler.start_new
        scheduler.cron '30 16-24 * * 1-5' do
          # take market snapshot
          puts '*** RUNNING SNAPSHOT OF MARKETS ***       ' + Time.now.to_s
          loader = self.new
          loader.clean
          loader.runSnapShot
          puts '*** MARKETSNAPSHOT SCHEDULER WAITING ***  ' + Time.now.to_s
        end

        scheduler.join

      end


      # Done here with commands

      opts.separator ""
      opts.separator "Common options:"
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
      # Another typical switch to print the version.
      opts.on_tail("-v", "--version", "Show version") do
        puts self.new.version[0]
        exit
      end

      # List of arguments.
      #opts.on("--report ticker1,ticker2,...", Array, "Example 'list' of arguments") do |list|
      #  options.list = list
      #end


    end

    opts.parse!(args)
    options
  end

  # parse()


  options = parse(ARGV)
  # puts 'ARGS: ' + options.args
  # puts options

  #
  # Commands implementation
  #

  case options.command
    when 'ticker'
      self.new.chainReport(options.args)
    when 'printreports'
      self.new.printReports
    when 'report'
      if options.args.length == 0
        self.new.runReport(options.report)
      else
        self.new.runReport(options.report, options.args)
      end
    when 'news'
      self.new.news(options.ticker, options.args)
    when 'snapshot'
      loader = self.new
      loader.clean
      loader.runSnapShot
    when 'correlationAll'
      self.new.runSnapShotCorrelations
    when 'correlation10'
      self.new.runSnapShotCorrelations10
    when 'correlated'
      self.new.correlated(options.ticker)
    when 'clean'
      self.new.clean
    when 'history'
      self.new.runSnapShotHistorical
    when 'test'
      self.new.testCorr

  end


end