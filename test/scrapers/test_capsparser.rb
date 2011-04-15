# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'helper'
require 'test/unit'
require 'scrapers/capsparser'
class Test_Capsparser< Test::Unit::TestCase
  def test_parseCaps
    Capsparser.new.parseCaps
  end
end