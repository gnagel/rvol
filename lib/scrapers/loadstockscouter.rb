require 'rubygems'
require 'open-uri'
require 'hpricot'

class LoadStockScouter
  
def loadBottom50
@urlBottom50	= "http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=1"
@response 	= ''



# open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
open(@urlTop50,:proxy=>"http://172.16.42.137:8080") { |f|

    # Save the response body
    @response = f.read
}

doc = Hpricot(@response)
 
# Retrive number of comments
#  - Hover your mouse over the 'X Comments' heading at the end of this article
#  - Copy the XPath and confirm that it's the same as shown below
table =  (doc/"html/body/div/div[2]/div[2]/div[2]/div/table[2]")
rown = (table/"tr")
puts rown

end


def loadTop50 
  @urlTop50 = "http://moneycentral.msn.com/investor/StockRating/srstopstocksresults.aspx?sco=50"
  
  @response2   = ''
  

  
  # open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
  open(@urlTop50,:proxy=>"http://172.16.42.137:8080") { |f|
  
      # Save the response body
      @response2 = f.read
  }
  
  doc = Hpricot(@response2)
   
  # Retrive number of comments
  #  - Hover your mouse over the 'X Comments' heading at the end of this article
  #  - Copy the XPath and confirm that it's the same as shown below
  table =  (doc/"html/body/div/div[2]/div[2]/div[2]/div/table[2]")
  rown = (table/"tr")
  puts rown
end

def loadTop10 

@urlTop10   = "http://moneycentral.msn.com/investor/StockRating/srstopstocksresults.aspx?sco=49"
@response3   = ''



# open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
open(@urlTop10,:proxy=>"http://172.16.42.137:8080") { |f|

    # Save the response body
    @response3 = f.read
}

doc = Hpricot(@response3)
 
# Retrive number of comments
#  - Hover your mouse over the 'X Comments' heading at the end of this article
#  - Copy the XPath and confirm that it's the same as shown below
table =  (doc/"html/body/div/div[2]/div[2]/div[2]/div/table[2]")
rown = (table/"tr")
puts rown
end

end