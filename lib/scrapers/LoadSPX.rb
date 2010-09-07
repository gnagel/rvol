require 'open-uri'
require 'CSV'


# This script loads the spx index tickers for later processing it saves them in a file spx.txt
#
# Usage check to see if this ticker is included in the spx: loadSpx = LoadSpx.new
#	        loadSpx.contains("AAPL")
# if the data is not loaded run 
#   							loadSpx = LoadSpx.new
#								loadSpx.loadSpx

class LoadSpx

def loadYahoo(link)

file = "spx.txt"

open(link) do |f|
		f.each_line do |line|
				CSV.parse(line) do |row|
				p row[0] 
				if(row[0]!=nil)
				File.open(file, 'a') {|f| f.write(row[0] + "\n") }
				end
								end
					end
												end
end

def loadSpx()

link1  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=0"
link2  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=50"
link3  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=100"
link4  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=150"
link5  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=200"
link6  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=250"
link7  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=300"
link8  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=350"
link9  = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=400"
link10 = "http://download.finance.yahoo.com/d/quotes.csv?s=@%5EGSPC&f=sl1d1t1c1ohgv&e=.csv&h=450"


loadYahoo(link1)
loadYahoo(link2)
loadYahoo(link3)
loadYahoo(link4)
loadYahoo(link5)
loadYahoo(link6)
loadYahoo(link7)
loadYahoo(link8)
loadYahoo(link9)
loadYahoo(link10)
end

def containsSpx(ticker)

	file = "spx.txt"

	f = File.open(file, 'r')
  
	f.each_line {|line|
	
	value = line.chomp
		if(value == ticker)

		return true
		end
	}
	return false
end



end




