require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/chain.rb'

class OptionChainsScraper

def initialize()
  @@log = Logger.new('error.log','daily') 
end

def loadData(ticker,date)
  puts 'loading ' + ticker + '  date: ' +date.to_s
  @url = "http://finance.yahoo.com/q/op?s="+URI.escape(ticker+"&m="+date)
  
  @response = ''
  @the_stack = []
  
  open(@url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|

  @response = f.read
  }
    
  # HPricot RDoc: http://code.whytheluckystiff.net/hpricot/
 doc = Hpricot(@response)  
 
 table = doc.search("//table[@class='yfnc_datamodoutline1']")

 values = (table/"//tr")
 
 count = 0
 for obj in values
     if obj.to_html.include? "C00"
       count +=1
      
       chain = parseTD(obj,"C",date,ticker) 
        if chain != nil
          @the_stack.push chain
        end 
     end
  
     if obj.to_html.include? "P00"
        count +=1
      
       chain =  parseTD(obj,"P",date,ticker)
       if chain != nil
         @the_stack.push chain
      end
     end
   
 end
  
  if count==0 
   # raise 'no chains for ' + ticker + '  date: ' +date.to_s
  end 
 
   
 return  @the_stack
end

def testInternetConnection?
  Ping.pingecho "google.com", 1, 80
end   

def parseTD(td,type,date,ticker)
     
      @chain
     
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
	    @chain = Chain.new(type,ticker,date,strike,symbol,last,chg,bid,ask,vol,open)
 
      
      end
     
 return @chain

end


end