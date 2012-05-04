require 'typhoeus'
require 'nokogiri'
class Test
  # To change this template use File | Settings | File Templates.

  response = Typhoeus::Request.get('http://en.wikipedia.org/wiki/List_of_S%26P_500_companies')
  puts response.to_s
  doc = Nokogiri::HTML(response.body)
  counter = 0
  doc.xpath("//tr").each do |tr|

       if tr.to_s.include?('www.nyse.com') || tr.to_s.include?('www.nasdaq.com')

           tr.xpath("//td").each do |td|
             puts '***********************'
             puts td.inner_text
             puts '***********************'

           end
       end

  end

end