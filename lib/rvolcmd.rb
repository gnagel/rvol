require 'rvol'
require 'optparse'
require 'optparse/time'
require 'ostruct'

#
# Main class for accessing the application. Commands can be entered from
# here with the option parser. Implementations methods are grouped at the bottom.
#
class Rvolcmd 
  include RVol

  # This hash will hold all of the options
  # parsed from the command-line by
  # OptionParser.
  options = {}

  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.encoding = "utf8"

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: rubyfinnance [options]"
      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-e","--earningsR","Generate a table of earnings") do
        RubyFinance.new.earningsReport
      end
      opts.on("-i","--indexR","Generate an index report") do
        RubyFinance.new.indexReport
      end
      opts.on("-r","--chainR [TICKER]","List chains for ticker report") do |ticker|
        RubyFinance.new.chainReport(ticker)
      end
      opts.on("-a","--chains","List all chains") do |ticker|
        RubyFinance.new.chainReportAll
      end
      opts.on("-s","--snapshot","Download market snapshot, will download the current market data") do
        RubyFinance.new.runSnapShot
      end
      opts.on("-c","--downloader","start cron type timer downloader, will run 5:00 PM every weekday") do
        RubyFinance.new.runCron
      end
      opts.separator ""
      opts.separator "Common options:"
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
      # Another typical switch to print the version.
      opts.on_tail("--version", "Show version") do
        puts OptionParser::Version.join('.')
        exit
      end
    end
    opts.parse!(args)
  rescue => e
    puts e.message.capitalize + "\n\n"
    puts opts
    exit 1

  end  # parse()

  #pp options
end  # class rvolcmd
