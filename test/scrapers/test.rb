require 'typhoeus'
require 'nokogiri'
class Test
  # To change this template use File | Settings | File Templates.
  response = Typhoeus::Request.get('http://investing.money.msn.com/investments/stock-income-statement/?symbol=nok')
  doc = Nokogiri::HTML(response.body)

  doc.xpath("//tr").each do |tr|
    if (tr.to_s.include?('id="NetIncome"'))
        puts 'Net income'
        puts tr.xpath("td[2]").inner_text
        puts tr.xpath("td[3]").inner_text
        puts tr.xpath("td[4]").inner_text
        puts tr.xpath("td[5]").inner_text
        puts tr.xpath("td[6]").inner_text
        puts '***************'
      end
  end

end