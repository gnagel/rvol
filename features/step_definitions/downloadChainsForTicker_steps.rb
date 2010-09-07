require 'resolv-replace'
require 'ping'
require "scrapers/optionschainsscraper"

Given /^there is a connection to the internet available$/ do
end

When /^I download chains for a given ticker$/ do
  data = OptionChainsScraper.loadChains("GOOG","2010-12")
end




