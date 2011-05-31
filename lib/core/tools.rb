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
    system('open '+url)
  end

  def openscouter(stock)
   url = 'http://moneycentral.msn.com/investor/StockRating/srsmain.asp?symbol='+stock
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
    openscouter(stock)
    opengooglefinance(stock)
    openedgar(stock)
  end

  def openedgar(stock)
    url = 'http://www.sec.gov/cgi-bin/browse-edgar?company=&match=&CIK='
    url2 = '&filenum=&State=&Country=&SIC=&owner=exclude&Find=Find+Companies&action=getcompany'
    together = url+stock+url2
   openwebpage(together)
  end


  def checkplatform
    if RUBY_PLATFORM.start_with? 'x86_64-darwin'

    else
      puts 'Oops your not using mac os x write the code for this!'
      Process.exit
    end
  end
end