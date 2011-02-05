# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'typhoeus'
require 'nokogiri'
class Scratchpad
 
 # response = Typhoeus::Request.get("http://moneycentral.msn.com/investor/stockrating/srstopstocksresults.aspx?sco=50")
 # doc = Nokogiri::HTML(response.body)
 # doc.search('//tr').each do |tr|
 #   if tr.to_s.include? 'http://investing.money.msn.com/investments/'
 #   puts tr
 #   end
 # end  
 
  response = Typhoeus::Request.get("http://en.wikipedia.org/wiki/List_of_S%26P_500_companies")    
  doc = Nokogiri::HTML(response.body)
  doc.css('a.external').each do |tick|
    if tick.to_s.include?('www.nyse.com')
      puts tick.inner_text
    end
  end
end