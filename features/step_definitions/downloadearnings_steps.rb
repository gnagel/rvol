require 'scrapers/earningsscraper'
require 'rfinance'
require 'ruport'
require 'core/store'


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
  
  
  table = Table(%w[Date Ticker impliedVolatility1 impliedvolatility2])
  
  @earnings.getHash.sort{|a,b| a[1]<=>b[1]}.each { |elem|
    
       table << [elem[1], elem[0].ticker, "0", "0"]
  }
  puts table
  
  Store.saveObject('test',@earnings)
  

end

Given /^I have a list of earnings with chains$/ do
  @eanings
end

When /^i call generate report$/ do
  Rfinance.generateReport
end

Then /^I get a nicely formatted report$/ do
  pending # express the regexp above with the code you wish you had
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
