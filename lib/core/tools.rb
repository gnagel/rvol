require 'launchy'
#
# Simple actions tools for everydat tasks like reaseaching a stock use researchstock method whitch will open
# Websites with useful info
# Stockscouter
# google finance
# marketwatch
#
class Tools
  def openwebpage(url)
    checkplatform
    #system('open '+url)
    Launchy.open(url)
  end

  def openscouter(stock)
    url = 'http://moneycentral.msn.com/investor/StockRating/srsmain.asp?symbol='+stock
    openwebpage(url)
  end

  def openfool(stock)
    url = 'http://caps.fool.com/Ticker/'+stock+'.aspx'
    openwebpage(url)
  end

  def opengooglefinance(stock)
    url = 'http://www.google.com/finance?q='+stock
    openwebpage(url)
  end

  #
  # Opens all kinds of pages scouter, edgar, etc
  #
  def researchStock(stock)
    openedgar(stock)
    openfool(stock)
    openscouter(stock)
    opengooglefinance(stock)
  end

  def openedgar(stock)
    url = 'http://www.sec.gov/cgi-bin/browse-edgar?company=&match=&CIK='
    url2 = '&filenum=&State=&Country=&SIC=&owner=exclude&Find=Find+Companies&action=getcompany'
    together = url+stock+url2
    openwebpage(together)
  end


  def checkplatform
    # launcy should handle all platforms
  end
end