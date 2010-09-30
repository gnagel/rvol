require 'scrapers/earningsscraper'
require 'rfinance'
require 'ruport'

Given /^i am connected to the internet$/ do
end

When /^i call downloadEarnings$/ do
  @earnings = EarningsScraper.getEarningsMonth2
end

Then /^I get a list of coming earnings for the next month$/ do

Earnings_Report.attachChains(@earnings)
Earnings_Report.generateReport(@earnings)
end
