# encoding: utf-8
require 'helper'
require 'scrapers/scraper'
require 'scrapers/etf'
require 'test/unit'
require 'typhoeus'
require 'nokogiri'

class Test_parsing  < Test::Unit::TestCase
  def test_parseetf100
   response = Scraper.down100VolETF
   doc = Nokogiri::HTML(response.body)
   regex = /[A-Z]{3,4}/
   i=0
   doc.search('//tr/td').search('//a[@href]').each do |td|
     if td.content.length <= 4 && regex =~ td.content
       puts i+=1
       puts td.content
     end
    end
  end
  def test_saveetf100
   begin
   Etf.new.parse100TopVolEtf
   rescue => boom
     flunk(boom.to_s)
   end
   
  end
end