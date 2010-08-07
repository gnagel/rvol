require 'date'
load 'optionschainsscraper.rb'

class LoadTodaysChains500

begin
file = "spx.txt"
chains = OptionChainsScraper.new()

t = Time.now
date = Date.new(t.year, t.mon, t.day)

File.open(file, "r") do |infile|
     while (line = infile.gets)
          puts "Fetching chain for:  " + line
		  # get the next 4 months of chains
          for i in 0..3
            begin
			date = date >> i
            data = chains.loadData(line,date.strftime("%Y-%m"))
          rescue => e
            
            puts 'LOADING TICKER: ' +line +' ON DATE ' +dates[i]+'  FAILED CARRYING ON'
    		puts "#{e.message}\n#{e.backtrace}"
			
            begin
            data = chains.loadData(line,dates[i])
            rescue
             puts 'TRY NUM 2: ' +line +' ON DATE ' +dates[i]+'  FAILED QUITING ON THIS ONE'
            end
            
          end
          end
          
     end
     puts 'DONE DOWNLOADING!'
    end
end

end

