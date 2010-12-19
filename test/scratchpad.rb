$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'helper'
require 'yaml'

class Scratchpad
  config = YAML.load_file 'lib/config.yml'
  puts config['default']
  puts config['test']
end