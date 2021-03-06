# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'helper'
require "model/earning"

class TestEarnings < Test::Unit::TestCase
  def test_addEarning
    earn = Earnings.new(DateTime.now)
    earn.put('AAPL','20100831')
    earn.put('GOOG','20100931')

    p earn.getKeys
    p earn.getKey('GOOG')
  rescue => e

    p e
  end

end