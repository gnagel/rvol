require 'dm-core'
require 'dm-validations'
  
#
# Holds 
#
class Ticker
  include DataMapper::Resource
  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  # A DateTime, for any date you might like.
  property :symbol,                      String, :unique => true
  property :index,                       String
  property :frontMonth,                  Float
  property :backMonth,                   Float
end



#
# Holds daily data for a stock 
#
class StockDaily 
  include DataMapper::Resource
  property :id,            Serial
  property :symbol,        String
  # A DateTime, for any date you might like.
  property :created_at,    DateTime  
  # l1 Last Trade (Price Only)
  property :price,         String
  # a2 average volume
  property :avolume,       String
  # v volume
  property :volume,        String
  # n name
  property :name,          String
  # q Ex-Dividend Date
  property :exdividenddate,String
  # y Dividend Yield
  property :dividendyield, String
  # d Dividend/Share
  property :dpershare,     String
end

class StockHistorical 
  include DataMapper::Resource
  property :id,    Serial
  property :open,  String
  property :high,  String
  property :low,   String
  property :close, String
  property :volume,String
end