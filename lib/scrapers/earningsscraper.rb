require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/earnings'
require "scrapers/optionschainsscraper"
require "core/dateutil"

class EarningsScraper
  
  
  
  # Generate the date string with a form like this: 20100209 = YYYYMMDD
  # this will return the next 30 dates and load the earnings for these dates only spx stocks are listed
  # returns a hash of earnigs for this day
  def EarningsScraper.getEarningsMonth
   
    t = DateTime.now
    @earningsHash = Earnings.new(t)
     
    t.step(t+30,step=1) { |n| 
      date = n.strftime("%Y%m%d") 
      EarningsScraper.getEarnings(date)
      
    }
    
    @earningsHash
  end

  # date must be in the form yyyymmdd: 20100209
  def EarningsScraper.getEarnings(date)
    
    url="http://biz.yahoo.com/research/earncal/"+date+".html"
    response = ''
    #local_filename = "data/earnings/earnings"+date+".txt"
    local_filename = "data/earnings/earnings.txt"
    
    # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
    open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|

      # Save the response body
      response = f.read
    }
    
    # HPricot RDoc: http://code.whytheluckystiff.net/hpricot/
    doc = Hpricot(response)
    
    
    chains = (doc/"//a[@href]")
  
  for obj in chains
   
    if obj.to_html.include? "http://finance.yahoo.com/q?"
      ticker = obj.inner_text
      if(EarningsScraper.containsSpx(ticker))
         @earningsHash.put(ticker,date)
        
      end
    end
  end

rescue Exception => e
  print e, "\n"
end


# is ticker in the S&P 500
def EarningsScraper.containsSpx(ticker)
  
  file = "./data/spx.txt"
  
  f = File.open(file, 'r')
  
  f.each_line {|line|
    
    value = line.chomp
    if(value == ticker)
     
      return true
    end
  }
  return false
end

# Attach chains to all earnings
def EarningsScraper.attachChains(earnings)
 
  earnings.getHash.each {|key, value|
    scraper = OptionChainsScraper.new
    date = DateTime.now
    for i in 1 .. 5
      if i > 1
       date = DateUtil.nextMonth(date)

       
    end
     parsedDate = date.strftime("%Y-%m")
     chains = scraper.loadData(key.ticker,parsedDate)
     key.addChains(parsedDate,chains)

    end
  }

end



end