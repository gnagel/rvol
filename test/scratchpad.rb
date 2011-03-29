# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'typhoeus'
require 'nokogiri'
require 'date'
#
# Used for quick testing of code snippets
#
class Scratchpad
  
  endDate = DateTime.now
  startDate = DateTime.now
  puts startDate << 1
  puts endDate.strftime("%b+%d+%Y")
  
  #"http://www.google.com/finance/historical?cid=696965&startdate=Feb+28%2C+2011&enddate=Mar+29%2C+2011&num=30&output=csv"
end