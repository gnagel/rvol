require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/chain.rb'

class OptionChainsScraper

def initialize()
  @@log = Logger.new('./log/error.log','daily') 
end

def loadData(ticker,date)
         #http://finance.yahoo.com/q/op?s=AAPL&m=2010-02
  @url = "http://finance.yahoo.com/q/op?s="+URI.escape(ticker+"&m="+date)
  
  @response = ''
  @the_stack = []
  
  open(@url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|
                  
    #puts "Fetched document: #{f.base_uri}"
     
    # Save the response body
    @response = f.read
  }
    
  # HPricot RDoc: http://code.whytheluckystiff.net/hpricot/
 doc = Hpricot(@response)  
 
 table = doc.search("//table[@class='yfnc_datamodoutline1']")
 
 values = (table/"//tr")
 for obj in values
     if obj.to_html.include? "C00"
       # puts "A CALL"
       chain = parseTD(obj,"C",date,ticker) 
        if chain != nil
          @the_stack.push chain
        end 
     end
  
     if obj.to_html.include? "P00"
       # puts "A PUT"
       chain =  parseTD(obj,"P",date,ticker)
       if chain != nil
         @the_stack.push chain
      end
     end
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
	  
      #local_filename = "data/chains"+"/"+ticker+"/"+date+".txt"
		
	    # create a chain holder object for the data
	    @chain = Chain.new(type,ticker,date,strike,symbol,last,chg,bid,ask,vol,open)
       
      end
     
 return @chain

end


def toFile(ticker,date,array)
  
  local_filename = 'data/chains'+'/'+ticker+'-'+date+'.txt'
  if !File.exist?(local_filename)
  
    array.length.times do |i|
    chain = array[i]
    File.open(local_filename, 'a') {|f| f.write(chain.type+','+chain.strike+','+chain.symbol+','+chain.last+','+chain.chg+','+chain.bid+','+chain.ask+','+chain.vol+','+chain.openInt+"\n") }
    end

  else
      @@log.error('file: '+ local_filename + ' exists already' )
    end



end
  #begin
  # run the thing
  #puts 'testing chain load'
  #chains = OptionChainsScraper.new
  #data = chains.loadData("GOOG","2010-07")
  #data = chains.loadData("GOOG","2010-04")
  #data = chains.loadData("GOOG","2010-05")
  # end the thing
  #end

end