# encoding: utf-8
require 'dm-core'
require 'dm-validations'
require 'model/stockdaily'

#
# Holds daily historical prices for a stock
#
class Stockhistorical
  include DataMapper::Resource
  property :id,    Serial, :required => true
  property :date,  DateTime , :required => true
  property :symbol,String, :required => true
  property :open,  String, :required => true
  property :high,  String, :required => true
  property :low,   String, :required => true
  property :close, String, :required => true
  property :volume,String, :required => true
end
