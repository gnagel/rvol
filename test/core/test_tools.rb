require 'test/unit'
require 'core/tools'
# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
class TestTools < Test::Unit::TestCase
  def test_openpage
    puts 'testing open browser'
    Tools.new.openwebpage('http://www.tonik.net')
  end
  def test_openpage
    begin
    Tools.new.openscouter('NOK')
    Tools.new.opengooglefinance('GOOG')
    Tools.new.openedgar('LVS')
    rescue => message
      flunk(message)
    end
  end

end