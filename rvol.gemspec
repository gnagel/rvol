# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rvol}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Toni Karhu"]
  s.date = %q{2011-07-10}
  s.default_executable = %q{rvol}
  s.email = %q{tonikarhu@gmail.com}
  s.executables = ["rvol"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".autotest",
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
    "gpl.txt",
    "lib/config.yml",
    "lib/core/cron.rb",
    "lib/core/dateutil.rb",
    "lib/core/downloader.rb",
    "lib/core/rlog.rb",
    "lib/core/tools.rb",
    "lib/core/util.rb",
    "lib/math/arraymath.rb",
    "lib/math/calculatechains.rb",
    "lib/math/calculatecorrelations.rb",
    "lib/math/calculatestd.rb",
    "lib/math/ivolatility.rb",
    "lib/model/chain.rb",
    "lib/model/earning.rb",
    "lib/model/portfolio.rb",
    "lib/model/stock.rb",
    "lib/model/stockcorrelation.rb",
    "lib/model/stockdaily.rb",
    "lib/model/stockhistorical.rb",
    "lib/reports/chainsreport.rb",
    "lib/reports/correlationSTDreport.rb",
    "lib/reports/dividendsreport.rb",
    "lib/reports/earningsreport.rb",
    "lib/reports/indexreport.rb",
    "lib/reports/ivolatilityreport.rb",
    "lib/reports/portfolioreport.rb",
    "lib/reports/report.rb",
    "lib/reports/reportprinter.rb",
    "lib/reports/sdreport.rb",
    "lib/reports/weekliesreport.rb",
    "lib/rvol.rb",
    "lib/rvolcmd.rb",
    "lib/scrapers/capsparser.rb",
    "lib/scrapers/earningsparser.rb",
    "lib/scrapers/etf.rb",
    "lib/scrapers/historicalscraper.rb",
    "lib/scrapers/optionschainsscraper.rb",
    "lib/scrapers/rss.rb",
    "lib/scrapers/scraper.rb",
    "lib/scrapers/stocks.rb",
    "lib/scrapers/stockscouter.rb",
    "lib/server/public/css/style.css",
    "lib/server/public/table-images/botleft.png",
    "lib/server/public/table-images/botright.png",
    "lib/server/public/table-images/left.png",
    "lib/server/public/table-images/right.png",
    "lib/server/server.rb",
    "lib/server/views/index.haml",
    "rvol.gemspec",
    "test/core/test_dateErrors.rb",
    "test/core/test_dateutil.rb",
    "test/core/test_tools.rb",
    "test/helper.rb",
    "test/math/test_arraymath.rb",
    "test/math/test_calculatechains.rb",
    "test/math/test_ivolatility.rb",
    "test/model/test_chain.rb",
    "test/model/test_earnings.rb",
    "test/model/test_stock.rb",
    "test/reports/test_chains_report.rb",
    "test/reports/test_correlationstdreport.rb",
    "test/reports/test_dividendsreport.rb",
    "test/reports/test_earnings_report.rb",
    "test/reports/test_index_report.rb",
    "test/reports/test_ivolatilityreport.rb",
    "test/reports/test_porfolioreport.rb",
    "test/reports/test_report.rb",
    "test/reports/test_sdreport.rb",
    "test/reports/test_weekliesreport.rb",
    "test/scrapers/test_capsparser.rb",
    "test/scrapers/test_earningssparser.rb",
    "test/scrapers/test_historicalscraper.rb",
    "test/scrapers/test_options_chains_scraper.rb",
    "test/scrapers/test_parsing.rb",
    "test/scrapers/test_rss_scraper.rb",
    "test/scrapers/test_scraper.rb",
    "test/scrapers/test_stockscouter.rb",
    "test/scrapers/test_stockscraper.rb",
    "test/scratchpad.rb",
    "test/test_rvol.rb"
  ]
  s.homepage = %q{http://github.com/tonik/rvol}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Rvol enables you to study market volatility from free data on the internet. I trade stocks, options and futures as a hobby.  Often some of the strategies that i have used  include looking at earnings dates for stocks and investing in these dates with different options strategies.   Rvol downloads options chains, calculates implied volatilites for them and has features  to list top 10 type of lists for potential investment opportunities.   Put call ratios are calculated , total amount of puts or calls for a particular company etc are available. These can be used to measure market sentiment.   Different filters can be used to find stocks/options with high volatilities, stocks with  high options volume for the day etc which are indicators of forthcoming events.   Rvol concentrates on the S&P500 at the moment. At anytime rvol can be used to download a snapshot from the market including stock prices, options chains, and earnings events for the month ahead.  Install: gem install rvol Usage: rvol -h (displays options),  To check info for a particular stock use: rvol -r AAPL.  All other features require the market snapshot to be taken use rvol -s to take a snapshot (20-30 minutes).  Then for instance rvol -e (earnings report with front month and backmonth volatilities)   **rvol is under development at the moment and is not in a stable state. Tested to work with ruby 1.9.2 on MAC OS X. ** (Linux should work, windows will need special libraries installed )}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<dm-migrations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0"])
      s.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_runtime_dependency(%q<ruport>, [">= 0"])
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<ruport-util>, [">= 0"])
      s.add_runtime_dependency(%q<rufus-scheduler>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<highline>, [">= 0"])
      s.add_runtime_dependency(%q<launchy>, [">= 0"])
    else
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<dm-migrations>, [">= 0"])
      s.add_dependency(%q<dm-validations>, [">= 0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_dependency(%q<ruport>, [">= 0"])
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<ruport-util>, [">= 0"])
      s.add_dependency(%q<rufus-scheduler>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<highline>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<dm-migrations>, [">= 0"])
    s.add_dependency(%q<dm-validations>, [">= 0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
    s.add_dependency(%q<ruport>, [">= 0"])
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<ruport-util>, [">= 0"])
    s.add_dependency(%q<rufus-scheduler>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<highline>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
  end
end

