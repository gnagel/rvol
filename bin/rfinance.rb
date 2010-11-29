#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'rfinance'
require 'optparse'
require 'optparse/time'
require 'ostruct'

#
# Main emethod for accessing the application. Commands can be entered from here with the option parser.
# Implementations methods are grouped at the bottom.
class Optparse
    #
    # Return a structure describing the options.
    #
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options = OpenStruct.new
      options.encoding = "utf8"
      options.transfer_type = :auto
      options.verbose = false

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: rfinnance.rb [options]"
        opts.separator ""
        opts.separator "Specific options:"
       
        opts.on("-earnings","--require opt","Generate a table of earnings") do |opt|
          
          Optparse.new.optEarningsReport(opt)  
        end

        opts.separator ""
        opts.separator "Common options:"
  
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

      end
      opts.parse!(args)
      options
    end  # parse()

  options = Optparse.parse(ARGV)  
  #
  # EACH OPTION HAS ITS OWN METHODS HERE:
  #  
  def optEarningsReport(opt)
    puts 'doing earnings woohoo' 
    puts opt+ ' was here '
  end
    
  end  # class Optparse
  