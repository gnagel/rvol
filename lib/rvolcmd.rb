# encoding: utf-8
# this enables the paths in the dev environment will see what happens in the gem
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'
require 'rvol'
#
#
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

      opts.on("-e", "--eval tickers", "Evaluate tickers separated separated by ',' , (-e AAPL,GOOG)") do |tickers|
        options.command = "eval"
        options.args = tickers
      end

      opts.on("-n", "--news TICKER ARGS", "Get a list of latest news for a ticker',' , (-n MCD)") do |ticker|
        options.command = "news"
        options.ticker = ticker
        options.args = args
      end

      opts.on("--study TICKER", "Study a stock from numerous web sites (opens the pages)',' , (--study MCD)") do |ticker|
        options.command = "study"
        options.ticker = ticker
      end

      opts.on("-s", "--snapshot", "Download market snapshot, type can be either snapshot ") do
        puts 'this can take 1h the first time about 20m after that depending on your processor,network,hd etc'
        options.command = "snapshot"
      end

      opts.on("", "--downloader", "start cron type timer downloader, will run 5:00 PM every weekday") do
        options.command = "downloader"
      end

      opts.on("--clean", "Cleanup old database if problems with data storage use this if there are errors with data loading") do |type|
        puts 'deleting old database'
        options.command = "clean"
      end

      opts.on("--correlationAll", "Calculate correlation for all instruments for the past 170 trading days") do
            options.command = "test"
      end

      opts.on("--correlation10", "Calculate correlation for all instruments for the past 10 trading days") do
            options.command = "test"
      end

      opts.on("--test", "used for to test a particular usecase") do
        options.command = "test"
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


  options = Rvolcmd.parse(ARGV)
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
    when 'eval'
      self.new.evaluate(options.args)
    when 'news'
      self.new.news(options.ticker, options.args)
    when 'snapshot'
      loader = self.new
      loader.runSnapShot
      loader.runSnapShotHistorical
    when 'correlationAll'
      self.new.runSnapShotCorrelations
    when 'correlation10'
        self.new.runSnapShotCorrelations10
    when 'downloader'
      downloader.runCron
    when 'study'
      self.new.study(options.ticker)
    when 'clean'
      self.new.clean
    when 'test'
      self.new.testCorr

  end


end