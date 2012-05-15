require 'typhoeus'
require 'nokogiri'
require '../../lib/scrapers/stocks'
require '../../lib/rvol'
class Test2

  #DataMapper.setup(:default, Rvol.config['rvol_main'])

  #
  # This will download the mean recommendation value for a stock!
  #
  #Ticker.all(:index=>'SP500').each do |ticker|
  url = "http://finance.yahoo.com/q/ao?s=AAPL&ql=1"
  response = Typhoeus::Request.get(url)
  doc = Nokogiri::HTML(response.body)
  doc.xpath("//tr").each do |tr|
      if(tr.to_s.include?('Mean Recommendation (this week):'))
          mean = tr.xpath("td[2]").inner_text
          if mean.to_f < 2.0 && mean !=nil && mean.length>0
            puts "AAPL MEAN: #{mean}"
          end
          #puts tr.xpath("td[4]").inner_text
      end
    end
  #end

end