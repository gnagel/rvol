require "./lib/rfinance"

Given /^I have a connection to the internet and I know what i want to download$/ do
  @ticker = 'VXX'
  
end

When /^I start the downloadTicker task$/ do
  @tick = Rfinance.loadPrice(@ticker)
end

Then /^I get the price for that ticker$/ do
  Float(@tick) > 0
  puts "got the price: "+@tick
end
