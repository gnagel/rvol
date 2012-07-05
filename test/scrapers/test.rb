require 'typhoeus'
require 'nokogiri'
class Test
  # To change this template use File | Settings | File Templates.

  #response = Typhoeus::Request.get('http://en.wikipedia.org/wiki/List_of_S%26P_500_companies')
  #doc = Nokogiri::HTML(response.body)

  #counter = 0
  #doc.xpath("//tr").each do |tr|
  #if(tr.to_s.include?('AAPL'))
  #        puts tr.xpath("td[1]").inner_text
  #        puts tr.xpath("td[4]").inner_text
  #end

  # end

  # http://www.google.com/finance?q=NYSE:LVS&fstype=ii

  #
  # Fields i want for pietrovski
  # Profitability

  # 1. Positive net income compared to last year (1 point)  -- > changing to quarter? or not
  # 2. Positive operating cash flow in the current year (1 point)
  # 3. Higher return on assets (ROA) in the current period compared to the ROA in the previous year (1 point)
  # 4. Cash flow from operations greater than Net Income (1 point)

  # Leverage, Liquidity and Source of Funds

  # 5. Lower ratio of long term debt to in the current period compared value in the previous year (1 point)
  # 6. Higher current ratio this year compared to the previous year (1 point)
  # 7. No new shares were issued in the last year (1 point)

  # Operating Efficiency

  # 8. A higher gross margin compared to the previous year (1 point)
  # 9. A higher asset turnover ratio compared to the previous year (1 point)

  response = Typhoeus::Request.get('http://www.google.com/finance?q=NYSE:LVS&fstype=ii')
  doc = Nokogiri::HTML(response.body)

  latestNet = 0
  beforeNet = 0

  count = 0
  doc.xpath("//tr").each do |tr|
    if (tr.to_s.include?('Net Income'))
      if count  % 2 == 0
        puts tr.xpath("td[2]").inner_text
        puts tr.xpath("td[3]").inner_text
        puts tr.xpath("td[4]").inner_text
        puts tr.xpath("td[5]").inner_text
        puts '***************'
      end
      count+=1
      if count == 8
        break
      end
    end

  end

  #puts (latestNet.to_f - beforeNet.to_f)

  #def parseNetIncome(tr)
  #  if (tr.to_s.include?('Net Income'))
  #    puts tr

   # end
  #end


end