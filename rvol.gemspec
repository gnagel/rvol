# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rvol}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Toni Karhu"]
  s.date = %q{2010-12-22}
  s.default_executable = %q{rvol}
  s.email = %q{tonikarhu@gmail.com}
  s.executables = ["rvol"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".project",
    ".settings/org.eclipse.ltk.core.refactoring.prefs",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/rvol",
    "features/rvol.feature",
    "features/step_definitions/rvol_steps.rb",
    "features/support/env.rb",
    "finance.mm",
    "lib/config.yml",
    "lib/core/cron.rb",
    "lib/core/dateutil.rb",
    "lib/core/downloader.rb",
    "lib/core/util.rb",
    "lib/math/arraymath.rb",
    "lib/math/ivolatility.rb",
    "lib/model/chain.rb",
    "lib/model/earning.rb",
    "lib/model/stock.rb",
    "lib/reports/chainsreport.rb",
    "lib/reports/earningsreport.rb",
    "lib/reports/indexreport.rb",
    "lib/reports/reportprinter.rb",
    "lib/rvol.rb",
    "lib/rvolcmd.rb",
    "lib/scrapers/earningsscraper.rb",
    "lib/scrapers/optionschainsscraper.rb",
    "lib/scrapers/rssScraper.rb",
    "lib/scrapers/stockscraper.rb",
    "rvol.gemspec",
    "test/core/test_dateutil.rb",
    "test/core/test_downloader.rb",
    "test/helper.rb",
    "test/math/test_arraymath.rb",
    "test/math/test_ivolatility.rb",
    "test/model/test_chain.rb",
    "test/model/test_earnings.rb",
    "test/model/test_stock.rb",
    "test/reports/test_chains_report.rb",
    "test/reports/test_earnings_report.rb",
    "test/reports/test_index_report.rb",
    "test/scrapers/test_options_chains_scraper.rb",
    "test/scrapers/test_stockscraper.rb",
    "test/scratchpad.rb",
    "test/test_rvol.rb"
  ]
  s.homepage = %q{http://github.com/tonik/rvol}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rvol enables you to study market volatility from free data on the internet. I trade stocks, options and futures as a hobby.  Often some of the strategies that i have used  include looking at earnings dates for stocks and investing in these dates with different options strategies.  <br> Rvol downloads options chains, calculates implied volatilites for them and has features  to list top 10 type of lists for potential investment opportunities.  <br> Put call ratios are calculated , total amount of puts or calls for a particular company etc are available. These can be used to measure market sentiment.  <br> Different filters can be used to find stocks/options with high volatilities, stocks with  high options volume for the day etc which are indicators of forthcoming events.  <br> Rvol concentrates on the S&P500 at the moment. At anytime rvol can be used to download a snapshot from the market including stock prices, options chains, and earnings events for the month ahead. <br> Install: gem install rvol Usage: rvol -h (displays options) <br> **rvol is under development at the moment and is not in a stable state. Tested to work with ruby 1.9.2 on Mac os x.**}
  s.test_files = [
    "test/core/test_dateutil.rb",
    "test/core/test_downloader.rb",
    "test/helper.rb",
    "test/math/test_arraymath.rb",
    "test/math/test_ivolatility.rb",
    "test/model/test_chain.rb",
    "test/model/test_earnings.rb",
    "test/model/test_stock.rb",
    "test/reports/test_chains_report.rb",
    "test/reports/test_earnings_report.rb",
    "test/reports/test_index_report.rb",
    "test/scrapers/test_options_chains_scraper.rb",
    "test/scrapers/test_stockscraper.rb",
    "test/scratchpad.rb",
    "test/test_rvol.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0"])
      s.add_runtime_dependency(%q<ruport>, [">= 0"])
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_runtime_dependency(%q<dm-migrations>, [">= 0"])
      s.add_runtime_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<ruport-util>, [">= 0"])
      s.add_runtime_dependency(%q<rufus-scheduler>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<dm-validations>, [">= 0"])
      s.add_dependency(%q<ruport>, [">= 0"])
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_dependency(%q<dm-migrations>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<ruport-util>, [">= 0"])
      s.add_dependency(%q<rufus-scheduler>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<dm-validations>, [">= 0"])
    s.add_dependency(%q<ruport>, [">= 0"])
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
    s.add_dependency(%q<dm-migrations>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<ruport-util>, [">= 0"])
    s.add_dependency(%q<rufus-scheduler>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

