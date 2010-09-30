require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/chain.rb'
require 'typhoeus'
require "core/dateutil"

class OptionChainsScraper



#
# load chains for the next 3 months.
#
def OptionChainsScraper.loadChains(ticker)
  
  chains = Array.new

  scraper = OptionChainsScraper.new

  hydra = Typhoeus::Hydra.new
  
  i=0
      
  ticker.each { |tick|  
  
  date = DateTime.now

  
  for i in 1 .. 3
      if i > 1
        date = DateUtil.nextMonth(date)
      end
        # this is the date for the url
        parsedDate = date.strftime("%Y-%m")
       

        url = "http://finance.yahoo.com/q/op?s="+URI.escape(tick+"&m="+parsedDate)
        request = Typhoeus::Request.new(url)
        request.on_complete { | response |
          
          doc = Hpricot(response.body)  
          table = doc.search("//table[@class='yfnc_datamodoutline1']")
          values = (table/"//tr")
          
          for obj in values
              if obj.to_html.include? "C00"
                
                chain = OptionChainsScraper.parseTD(obj,"C",tick) 
                 if chain != nil
                   chains.push chain
                
                 end 
              end

              if obj.to_html.include? "P00"
                chain =  OptionChainsScraper.parseTD(obj,"P",tick)
                if chain != nil
                  chains.push chain
                 
                end
              end
          end
  
        }
        
        
        
       #puts 'queueing' + tick + parsed
       
       hydra.queue(request)

  end # end for i in ..
  
  }
        
  p 'starting hydra'
  hydra.run
  p 'hydra done'
  
  chains
end



# Parses a td 
def OptionChainsScraper.parseTD(td,type,ticker)
     
      parsed = (td/"//td")
      if parsed.length==8
      
      strike  = parsed[0].inner_text
      symbol  = parsed[1].inner_text
      last    = parsed[2].inner_text
      chg     = parsed[3].inner_text
      bid     = parsed[4].inner_text
      ask     = parsed[5].inner_text
      vol     = parsed[6].inner_text
      open    = parsed[7].inner_text
	  

	    # create a chain holder object for the data
      dateS = DateUtil.getDateFromOptSymbol(ticker,symbol)
   
	    chain = Chain.new(type,ticker,dateS,strike,symbol,last,chg,bid,ask,vol,open)
      
      
      end
     
 return chain

end


end