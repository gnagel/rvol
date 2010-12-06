
require 'nokogiri'
require 'typhoeus'
require 'helper'
require 'math/arraymath'
require 'model/chain'

class Scratchpad
  def scrape
    url = "http://finance.yahoo.com/q/op?s=AAPL"
    response = Typhoeus::Request.get(url)
    doc = Nokogiri::HTML(response.body)
    #rows = doc.search("//table[@class='yfnc_datamodoutline1']/tr/td")

    doc.xpath("//table[@class='yfnc_datamodoutline1']",'//tr').each do |tr|
      if tr.inner_text.include? "AAPL"
        puts '*'
        i = 0
        type = ""
        ticker ="AAPL"
        dateS = ""
        symbol =""
        strike =""
        last=""
        chg=""
        bid=""
        ask=""
        vol=""
        open=""

        tr.css(".yfnc_h").each do |td|
          case i
          when 0 then strike = td.inner_text
          when 1 then symbol = td.inner_text
          when 2 then last   = td.inner_text
          when 3 then chg    = td.inner_text
          when 4 then bid    = td.inner_text
          when 5 then ask    = td.inner_text
          when 6 then vol    = td.inner_text
          when 7 then open   = td.inner_text
          end

          i+=1
        end

        if symbol == "C00"
          type = "C"
        end
        if symbol == "P00"
          type = "P"
        end
        chain = Chain.new(type,ticker,dateS,strike,symbol,last,chg,bid,ask,vol,open)
        puts chain.toString
      end
    end
  end

  begin
    puts 'begin'
    s = Scratchpad.new
    s.scrape
  end
end