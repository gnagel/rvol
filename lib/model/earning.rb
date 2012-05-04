# encoding: utf-8
require 'dm-core'
require 'dm-validations'

class Earning
  include DataMapper::Resource

  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime, :required => true  # A DateTime, for any date you might like.
  property :date,                        String, :required => true
  property :ticker,                      String, :unique => true
  property :frontMonth,                  Float
  property :backMonth,                   Float

  #def initialize(date,ticker)
  #  self.date = date
  #  self.ticker = ticker
  #  self.created_at = Time.now
  #end

end