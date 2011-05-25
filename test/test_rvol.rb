# encoding: utf-8
require 'helper'
require 'Rvol'
require 'Rvolcmd'

class TestRvol < Test::Unit::TestCase
  include Rvol

  def test_length
    s = "Hello, World!"
    assert_equal(13, s.length)
  end

  def test_config
    begin
      puts Rvol.config
    rescue => e
      flunk("config fucked")
    end
  end

  def test_commands
    begin
      puts 'jeejjee'
    rescue => e
      puts e
      flunk("failed test")
    end
  end
end
