require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rvol"
    gem.summary ="Gem for analysing financial data mainly concentrating on options and stokcs associated with them. Usage: rvol -h
    	A database is created for datamining stocks , options, and implied volatilities which are calculated
    	in the creation of the database. Earnings are downloaded and listed with implied volatilities for front and back
    	month options. There are some reports which can be generated after the database is downloaded look at rvol -p.
      <br>
      To check info for a particular stock use: rvol -t AAPL.
      <br>
      All other features require the market snapshot to be taken use rvol -s to take a snapshot (20-30 minutes)."

    gem.email = "tonikarhu@gmail.com"
    gem.homepage = "http://github.com/tonik/rvol"
    gem.authors = ["Toni Karhu"]
    gem.add_development_dependency "cucumber"
    gem.add_dependency "dm-core"
    gem.add_dependency "dm-migrations"
    gem.add_dependency "dm-validations"
    gem.add_dependency "dm-sqlite-adapter"
    # problem in mac os x do : gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
    # gem.add_dependency "mysql"
    # and here
    # gem install dm-mysql-adapter --no-rdoc --no-ri -- --with-mysql-dir=/usr/local/mysql/
    gem.add_dependency "dm-mysql-adapter"
    gem.add_dependency "peach"
    gem.add_dependency "ruport"
    gem.add_dependency "typhoeus"
    gem.add_dependency "ruport-util"
    gem.add_dependency "rufus-scheduler"
    gem.add_dependency "nokogiri"
    gem.add_dependency "sinatra"
    gem.add_dependency "highline"
    gem.add_dependency "launchy"
    gem.add_dependency "statsample"
    
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

#begin
#  require 'rcov/rcovtask'
#  Rcov::RcovTask.new do |test|
#    test.libs << 'test'
#    test.pattern = 'test/**/test_*.rb'
#    test.verbose = true
#    test.rcov_opts = ['--exclude', '/gems/']
#  end
#rescue LoadError
#  task :rcov do
#    abort "RCov is not available. In order to run rcov, you must: sudo gem install rcov"
#  end
#end

task :test => :check_dependencies

#begin
#  require 'cucumber/rake/task'
#  Cucumber::Rake::Task.new(:features) do
#    |feat|
#       feat.rcov = true
#  task :features => [:check_dependencies,:install]
#  end
#rescue LoadError
#  task :features do 
#    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
#  end
#end

task :default => [:test,:features]

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rvol #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :clean do
  puts 'deleting database'
  if File.exists?(ENV['HOME']+'/.rvol'+'/marketsnapshot.db')
    Dir.delete(ENV['HOME']+'/.rvol'+'/marketsnapshot.db')
  end
end

