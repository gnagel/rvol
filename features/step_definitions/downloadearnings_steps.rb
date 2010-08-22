require "./lib/earningsscraper"

Given /^i am connected to the internet$/ do
     Ping.pingecho "google.com", 1, 80
end

When /^i call downloadEarnings$/ do
  earnings = EarningsScraper.new()
  @earnings = earnings.getEarnings30
end

Then /^I get a list of coming earnings for the next month$/ do
  @earnings != nil
  #@earnings.getHash.each {|key, value| puts "#{key} is #{value}" }
   array = @earnings.getHash.sort {|a,b| a[1] <=> b[1]}
   array.each {|arr| puts "#{arr[0]} #{arr[1]}"}
   
  
end

Given /^I have a list of earnings$/ do
  @earnings != nil
end

When /^i call attachChains$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I get a list of chains for the companies in the earnings report$/ do
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
