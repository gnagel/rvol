# encoding: utf-8

require 'test/unit'
require 'model/financialtatement'
require 'Nokogiri'

class TestIncomestatement < Test::Unit::TestCase
  def test_Incomestatement
    income = Incomestatement.new
  end

  def test_data
    file =  File.dirname(__FILE__)+'/istamenttest.html'
    puts file
    response = File.open(file,'r')
    doc = Nokogiri::HTML(response)

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
          puts tr.xpath("td[6]").inner_text
          puts '***************'
        end
        count+=1
        if count == 8
          break
        end
      end

    end
  end

end
