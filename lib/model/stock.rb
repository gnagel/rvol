require 'dm-core'
require 'dm-validations'
  
#
# Holds Ticker names for different indexes
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
  property :created_at,    DateTime  # A DateTime, for any date you might like.
  property :price,         String    # l1 Last Trade (Price Only)
  property :avolume,       String    # a2 average volume
  property :volume,        String    # v volume
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
  property :id,    Serial
  property :date,  DateTime 
  property :open,  String
  property :high,  String
  property :low,   String
  property :close, String
  property :volume,String
end