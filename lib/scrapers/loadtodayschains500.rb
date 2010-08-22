require 'date'
require 'optionschainsscraper'
require 'util'

class LoadTodaysChains500

begin
file = "../data/spx.txt"
chains = OptionChainsScraper.new()
util = Util.new
date = DateTime.now

File.open(file, "r") do |infile|
     while (line = infile.gets)
          puts "Fetching chain for:  " + line
		  # get the next 4 months of chains
      date = DateTime.now
      for i in 0..3
          begin
            
            data = chains.loadData(line,date.strftime("%Y-%m"))
          
          rescue => e
            puts 'LOADING TICKER: ' +line +' FAILED CARRYING ON'
    		    puts "#{e.message}\n#{e.backtrace}"

            begin
              data = chains.loadData(line,date.strftime("%Y-%m"))
            rescue
              puts 'TRY NUM 2: ' +line +'  FAILED QUITING ON THIS ONE'
            end
              date = util.nextMonth(date)
          end
          end
          
     end
     puts 'DONE DOWNLOADING!'
    end
end

end

