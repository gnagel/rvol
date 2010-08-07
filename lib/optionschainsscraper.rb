require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'FileUtils'
require 'model/chain.rb'

class OptionChainsScraper

def initialize()
end

def loadData(ticker,date)
         #http://finance.yahoo.com/q/op?s=AAPL&m=2010-02
  @url = "http://finance.yahoo.com/q/op?s="+URI.escape(ticker+"&m="+date)
  
  @response = ''
  
  open(@url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|
                  
    puts "Fetched document: #{f.base_uri}"
     
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
      parseTD(obj,"C",date,ticker)
    end
  
  if obj.to_html.include? "P00"
     # puts "A PUT"
     parseTD(obj,"P",date,ticker)
  end
 
  end

end 

def parseTD(td,type,date,ticker)
     
		
      #FileUtils.mkdir 'data/chains/'+ticker
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
		
      local_filename = 'data/chains'+'/'+ticker.chop+'-'+date+'.txt'
      File.open(local_filename, 'a') {|f| f.write(type+','+strike+','+symbol+','+last+','+chg+','+bid+','+ask+','+vol+','+open+"\n") }
	  
	  # create a chain holder object for the data
	  chain = Chain.new(strike,symbol,last,chg,bid,ask,vol,open)
      
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