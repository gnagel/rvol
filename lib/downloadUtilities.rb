require 'open-uri'
require 'CSV'

class DownloadUtilities

def downloadStockPrice(ticker)

    url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+ticker+'&f=sl1d1t1c1ohgv&e=.csv'

	  #open(url,:proxy => "http://172.16.42.137:8080") { |f|
	  open(url) { |f|

		file =  f.read
		splitted = file.split(',')
		puts splitted[1]
		
		return splitted[1]

    }
end
# quick self test
begin 
scrape = DownloadUtilities.new
scrape.downloadStockPrice('GOOG')
end

end