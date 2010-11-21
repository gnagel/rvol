require 'helper'
require 'rubygems'
require "model/stock"
require "core/datapersistence"
require "core/downloader"


 begin

   d = Downloader.new
   d.downloadEarnings
 end