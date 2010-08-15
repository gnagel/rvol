require 'open-uri'

class DownloadUtilities

def downloadStockPrice(ticker)

    url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+ticker+'&f=sl1d1t1c1ohgv&e=.csv'

	  open(url) { |f|

		file =  f.read
		splitted = file.split(',')
	
		return splitted[1]

    }
end

def testInternetConnection?
   Ping.pingecho "google.com", 1, 80
end

end