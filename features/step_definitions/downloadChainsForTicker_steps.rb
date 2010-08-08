require 'resolv-replace'
require 'ping'
require "./lib/optionschainsscraper.rb"

Given /^there is a connection to the internet available$/ do
 #puts Ping.pingecho "google.com", 1, 80
 chains = OptionChainsScraper.new()
 chains.testInternetConnection?
end

When /^I download chains for a given ticker$/ do
  chainsScraper = OptionChainsScraper.new()
  data = chainsScraper.loadData("GOOG","2010-12")
  puts 'got this many chains: '
  puts data.length
  data.length.times do |i|
    chainO = data[i]
    puts chainO
    chainO.toString

  end
  
  # write to file 
  chainsScraper.toFile("GOOG","2010-12",data)
end

Then /^I should get a set of options chains containing all chains for that ticker$/ do
  local_filename = 'data/chains'+'/'+"GOOG"+'-'+'2010-12'+'.txt'
  File.exist?(local_filename)
end


