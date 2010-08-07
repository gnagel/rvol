require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/earning.rb'

class EarningsScraper
  
  
  
  # Generate the date string with a form like this: 20100209
  #                                                 YYYYMMDD
  # this will return the next 30 dates and load the earnings for these dates only spx stocks are listed
  def dayString
  
    local_filename = "data/earnings/earnings.txt"
    if(File.exist?(local_filename))
      File.delete(local_filename)
    end
    
    t = Date.today
    
    t.step(t+30,step=1) { |n| 
      date = n.strftime("%Y%m%d") 
      getEarnings(date)
    }
    
  end
  
  # Today
  def today
    t = Date.today
    t.strftime("%Y%m%d")
  end
  
  # is ticker in the S&P 500
  def containsSpx(ticker)
    
    file = "spx.txt"
    
    f = File.open(file, 'r')
    
    f.each_line {|line|
      
      value = line.chomp
      if(value == ticker)
        puts "FOUND  " + value
        return true
      end
    }
    return false
  end
  
  # date must be in the form yyyymmdd: 20100209
  def getEarnings(date)
    
    url="http://biz.yahoo.com/research/earncal/"+date+".html"
    response = ''
    #local_filename = "data/earnings/earnings"+date+".txt"
    local_filename = "data/earnings/earnings.txt"
    
    # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
    open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|
      
      puts "Fetched document: #{f.base_uri}"
      
      # Save the response body
      response = f.read
    }
    
    # HPricot RDoc: http://code.whytheluckystiff.net/hpricot/
    doc = Hpricot(response)
    
    
    chains = (doc/"//a[@href]")

  for obj in chains
    #puts obj.
    if obj.to_html.include? "http://finance.yahoo.com/q?"
      ticker = obj.inner_text
      if(containsSpx(ticker))
      puts "contains" +ticker
      File.open(local_filename, 'a') {|f| f.write(ticker+','+date+"\n") }
	  # create earnings object
	  earnings = Earning.new(ticker,date)
      end
    end
  end
  



  

rescue Exception => e
  print e, "\n"
end

#TODO write this part as tests

begin 
  test = EarningsScraper.new 
  puts test.dayString
end

end