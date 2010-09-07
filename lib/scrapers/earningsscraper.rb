require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/earnings'
require "scrapers/optionschainsscraper"
require "core/dateutil"
require 'typhoeus'

class EarningsScraper


  # Generally, you should be running requests through hydra. Here is how that looks
  
  def EarningsScraper.getEarningsMonth2
    hydra = Typhoeus::Hydra.new
    earnings = Array.new
    
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
            if(EarningsScraper.containsSpx(ticker))
                earnings.push(Earning.new(date,ticker))
               puts ticker
            end
          end
        end
        
      } 
         hydra.queue(request)
    }
    p 'starting hydra'
    hydra.run
    p 'hydra done'

    earnings  
  end
  

# is ticker in the S&P 500
def EarningsScraper.containsSpx(ticker)
  
  file = "./data/spx.txt"
  
  f = File.open(file, 'r')
  
 f.each_line { | line |
    
    value = line.chomp
    if(value == ticker)
     
      return true
    end
  }
  return false
end

end
