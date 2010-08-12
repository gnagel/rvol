require 'downLoadUtilities'

module Rfinance
  
def Rfinance.loadPrice(ticker)
  scrape = DownloadUtilities.new
  scrape.downloadStockPrice(ticker)
end

end