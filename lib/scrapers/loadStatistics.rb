require 'rubygems'
require 'open-uri'
require 'hpricot'

@urlTop50	= "http://moneycentral.msn.com/investor/StockRating/srstopstocksresults.aspx?sco=50"
@urlTop10   = "http://moneycentral.msn.com/investor/StockRating/srstopstocksresults.aspx?sco=49"
@response 	= ''

proxy_addr = 'http://192.168.1.106:'
proxy_port = '3128'

# open-uri RDoc: http://stdlib.rubyonrails.org/libdoc/open-uri/rdoc/index.html
open(@urlTop10,:proxy=>"http://172.16.42.137:8080") { |f|

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
