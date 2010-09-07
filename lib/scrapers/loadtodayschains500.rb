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
        
		  # get the next 4 months of chains
      date = DateTime.now
      for i in 0..3
          begin
            
            data = chains.loadData(line,date.strftime("%Y-%m"))
          
          rescue => e
          

            begin
              data = chains.loadData(line,date.strftime("%Y-%m"))
            rescue
             
            end
              date = util.nextMonth(date)
          end
          end
          
     end
     puts 'DONE DOWNLOADING!'
    end
end

end

