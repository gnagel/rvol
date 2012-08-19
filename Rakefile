require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rvol"
    gem.summary ="Gem for creating a database for datamining stock markets focusing on SP500 data. The created database
could be used for instance from R or Matlab or similar to do quantitative analysis. You could script new datamining
functions extending the Rvol library, load the data into a statistics package, or use it with your own quantitative
framework.  Usage: rvol -s will create the database. The database contains stocks (with industries), options, and
implied volatilities and calculated standard deviations for the day. Earnings are downloaded and listed with implied
volatilities for front and back month options. There are some reports, which can be generated after the database is
downloaded look at rvol -p. There is a funtion to calculate correlations between stocks in the same industry groups
(--correlationAll, --correlation10 (10 day correlation),this will take a long time and jruby is recommended for a better use of system resources. Have a look at the website
if you want to use mysql for a more robust system."
    gem.email = "tonikarhu@gmail.com"
    gem.homepage = "http://github.com/tonik/rvol"
    gem.authors = ["Toni Karhu"]
    gem.add_development_dependency "cucumber"
    gem.add_dependency "json_pure"
    gem.add_dependency "data_mapper"
    gem.add_dependency "dm-sqlite-adapter"
    # problem in mac os x do : gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
    #gem.add_dependency "mysql"
    # and here
    # gem install dm-mysql-adapter --no-rdoc --no-ri -- --with-mysql-dir=/usr/local/mysql/
    #gem.add_dependency "dm-mysql-adapter"
    gem.add_dependency "peach"
    gem.add_dependency "ruport"
    gem.add_dependency "typhoeus"
    gem.add_dependency "ruport-util"
    gem.add_dependency "rufus-scheduler"
    gem.add_dependency "nokogiri"
    gem.add_dependency "statsample"
    gem.add_dependency "rufus-scheduler"

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

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rvol #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


