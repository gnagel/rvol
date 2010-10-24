require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/earning'
require "scrapers/optionschainsscraper"
require "core/dateutil"
require 'typhoeus'

class EarningsScraper

  #
  # Generally, you should be running requests through hydra. Here is how that looks  
  #
  def EarningsScraper.getEarningsMonth2
    hydra = Typhoeus::Hydra.new
    earnings2 = Array.new
    
    t = DateTime.now
    t.step(t+30,step=1) { | n |
      date = n.strftime("%Y%m%d")
       
      url="http://biz.yahoo.com/research/earncal/"+date+".html"
      request = Typhoeus::Request.new(url)
      
     request.on_complete { | response |
       
        doc = Hpricot(response.body)
        chains = (doc/"//a[@href]")
        
        for obj in chains

          if obj.to_html.include? "http://finance.yahoo.com/q?"
            ticker = obj.inner_text
                earnings2 << Earning.new(date,ticker)
          end
          
        end
        
      } 
         hydra.queue(request)
    }
    p 'starting hydra'
    hydra.run
    p 'hydra done'

    return earnings2  
  end
  
end
