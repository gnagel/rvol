# encoding: utf-8
require 'dm-core'
require 'dm-validations'
require 'model/stockhistorical'

#
# Holds daily data for a stock
#
class Stockdaily
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
