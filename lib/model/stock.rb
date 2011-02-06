# encoding: utf-8
require 'dm-core'
require 'dm-validations'
#
# Holds Ticker names for different indexes
#
class Ticker
  include DataMapper::Resource
  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime, :required => true  # A DateTime, for any date you might like.
  property :symbol,                      String, :unique => true
  property :index,                       String, :required => true
  property :frontMonth,                  Float
  property :backMonth,                   Float
  property :totalCalls,                  Integer
  property :totalPuts,                   Integer
end





