# encoding: utf-8
require 'helper'
require 'test/unit'
require 'math/calculatecorrelations'

class Correlation < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    puts 'testing correlations calculation'
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # test 1 year correlations
  def test_correlationcalculation1Year
    begin
      puts 'testing calculate correlations RF'
      Calculatecorrelations.new.calculateYearlyCorrelationRF
    end
  end
   # test 20 day correlation calculation
    def test_correlationcalculation10Days
      begin
        puts 'testing calculate correlations 10 days'
        Calculatecorrelations.new.calculateCurrentCorrelation(10)
      end
    end
     # test 20 day correlation calculation
  def test_correlationcalculation20Days
    begin
      puts 'testing calculate correlations 30 days'
      Calculatecorrelations.new.calculateCurrentCorrelation(30)
    end
  end
end