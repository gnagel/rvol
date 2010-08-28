require "scrapers/earningsscraper"
require "rfinance"

Given /^i am connected to the internet$/ do
     Ping.pingecho "google.com", 1, 80
end

When /^i call downloadEarnings$/ do
  @earnings = Rfinance.loadEarnings
end         

Then /^I get a list of coming earnings for the next month$/ do
  @earnings != nil
  
end

Given /^I have a list of earnings$/ do
  @earnings = Rfinance.loadEarnings
end

When /^i call attachChains$/ do

  Rfinance.attachChainsToEarnings(@earnings)
end

Then /^I get a list of chains for the companies in the earnings report$/ do
  @earnings.getHash.each { |key, value|
     puts key.ticker
     puts value
  
  @earnings.getHash.sort{|a,b| a[1]<=>b[1]}.each { |elem|
       puts "#{elem[1]}, #{elem[0].ticker}"
     }
  }
end

Given /^I i have a company i want skew information$/ do
  pending # express the regexp above with the code you wish you had
end

When /^i call calculateSkews$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I get a list of skews for the company$/ do
  pending # express the regexp above with the code you wish you had
end
