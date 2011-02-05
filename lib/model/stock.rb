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

#
# Holds daily data for a stock
#
class StockDaily
  include DataMapper::Resource
  property :id,            Serial
  property :symbol,        String, :required => true
  property :created_at,    DateTime, :required => true  # A DateTime, for any date you might like.
  property :price,         String, :required => true    # l1 Last Trade (Price Only)
  property :avolume,       String, :required => true    # a2 average volume
  property :volume,        String, :required => true    # v volume
  property :name,          String    # n name
  property :exdividenddate,String    # q Ex-Dividend Date
  property :dividendyield, String    # y Dividend Yield
  property :dpershare,     String    # d Dividend/Share
end

#
# Holds daily historical prices for a stock
#
class StockHistorical
  include DataMapper::Resource
  property :id,    Serial, :required => true
  property :date,  DateTime , :required => true
  property :open,  String, :required => true
  property :high,  String, :required => true
  property :low,   String, :required => true
  property :close, String, :required => true
  property :volume,String, :required => true
end