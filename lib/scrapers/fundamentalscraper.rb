#
# Scrapes fundamental data from msn
#
class Fundamentalscraper

  def downloadIncomeStatement(symbol)
       response = Scraper.new.downloadIncomeStamentMSN(symbol)
       doc = Nokogiri::HTML(response.body)
       income1 = Incomestatement.new
       parseField('id="NetIncome"',doc,income1, 'NetIncome')
  end

  def parseField(fieldName, doc, object, method)
    doc.xpath("//tr").each do |tr|

      if (tr.to_s.include?(fieldName))
        puts 'Net income'
        text1 = tr.xpath("td[2]").inner_text
        text2 = tr.xpath("td[3]").inner_text
        text3 = tr.xpath("td[4]").inner_text
        text4 = tr.xpath("td[5]").inner_text
        text5 = tr.xpath("td[6]").inner_text

        object.send(:method, text1)

      end
    end
  end
end