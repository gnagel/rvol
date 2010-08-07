require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'

class EconomicScraper


 $local_filename = "data/economic/economicevents.txt"
# Generate the date string with a form like this: 20100209
#                                                 YYYYMMDD
# this will return the next 30 dates and load the earnings for these dates only spx stocks are listed
def loadWeek
  
 puts 
 # if(File.exist?($local_filename))
 # File.delete($local_filename)
  #File.new($local_filename)
 # end
  
  t = Date.today

  getEarnings(t.strftime("%Y%W"))

  
end



# date must be in the form yyyymmdd: 20100209
def getEarnings(week)

url="http://biz.yahoo.com/c/ec/"+week+".html"
response = ''

# open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}") { |f|
                  
    puts "Fetched document: #{f.base_uri}"     
    # Save the response body
    response = f.read
}
    
  # HPricot RDoc: http://code.whytheluckystiff.net/hpricot/
  doc = Hpricot(response)

  table = (doc/"/html/body/p[2]/table[2]")
  events = (table/"tr")
  # puts chains
  i = 0
  for obj in events
    if(i!=0)
 
    econ = obj.inner_text
    puts "Event:  "+econ 
    File.open($local_filename, 'w+') {|f| f.write(econ+"\n") }
    end
  i=i+1
  end
 
rescue Exception => e
  print e, "\n"
end


begin
  
test = EconomicScraper.new 
test.loadWeek

end
end