require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rvol"
    gem.summary ="Rvol enables you to study market volatility from free data on the internet.
    I trade stocks, options and futures as a hobby.  Often some of the strategies that i have used 
    include looking at earnings dates for stocks and investing in these dates with different options
    strategies. 
    
    Rvol downloads options chains, calculates implied volatilites for them and has features 
    to list top 10 type of lists for potential investment opportunities. 
    
    Put call ratios are calculated , total amount of puts or calls for a particular company etc are available.
    These can be used to measure market sentiment. 
   
    Different filters can be used to find stocks/options with high volatilities, stocks with 
    high options volume for the day etc which are indicators of forthcoming events. 
    
    Rvol concentrates on the S&P500 at the moment. At anytime rvol can be used to download a snapshot from the
    market including stock prices, options chains, and earnings events for the month ahead.
  
    Install: gem install rvol
    Usage: rvol -h (displays options), 
    To check info for a particular stock use: rvol -r AAPL. 
    All other features require the market snapshot to be taken use rvol -s to take a snapshot (20-30 minutes). 
    Then for instance rvol -e (earnings report with front month and backmonth volatilities) 
    
    **rvol is under development at the moment and is not in a stable state. Tested to work with ruby 1.9.2 on MAC OS X. **
    (Linux should work, windows will need special libraries installed )
    "
    gem.email = "tonikarhu@gmail.com"
    gem.homepage = "http://github.com/tonik/rvol"
    gem.authors = ["Toni Karhu"]
    gem.add_development_dependency "cucumber"
    gem.add_development_dependency  "shoulda"
    gem.add_dependency "dm-core", ">= 1.1.0"
    gem.add_dependency "dm-validations", ">= 1.1.0"
    gem.add_dependency "dm-sqlite-adapter", ">= 1.1.0"
    gem.add_dependency "dm-migrations", ">= 1.1.0"
    gem.add_dependency "ruport"
    gem.add_dependency "typhoeus"
    gem.add_dependency "ruport-util"
    gem.add_dependency "rufus-scheduler"
    gem.add_dependency "nokogiri"
    gem.add_dependency "sinatra"
    gem.add_dependency "launchy"
    gem.add_dependency "choice"
    gem.add_dependency "highline"
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test' 
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
    test.rcov_opts = ['--exclude', '/gems/']
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install rcov"
  end
end

task :test => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do
    |feat|
       feat.rcov = true
  task :features => :check_dependencies
  end
rescue LoadError
  task :features do 
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rvol #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


