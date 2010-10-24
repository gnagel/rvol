require 'dm-core'
require 'dm-validations'

class Stock
  include DataMapper::Resource
  
  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  # A DateTime, for any date you might like.
  property :symbol,                      String
  property :ask,                         Float
  property :averageDailyVolume,          Float
  property :bid,                         Float
  property :askRealtime,                 Float
  property :bidRealtime,                 Float
  property :bookValue,                   Float
  property :change_PercentChange,        String
  property :change,                      Float
  property :commission,                  Float
  property :changeRealtime,              Float
  property :afterHoursChangeRealtime,    String
  property :dividendShare,               Float
  property :lastTradeDate,               String
  property :tradeDate,                   String
  property :earningsShare,               String
  property :ePSEstimateCurrentYear,      Float
  property :ePSEstimateNextYear,         Float
  property :ePSEstimateNextQuarter,      Float
  property :daysLow,                     Float
  property :daysHigh,                    Float
  property :yearLow,                     Float
  property :yearHigh,                    Float
  property :yearLow,                     Float
  property :yearHigh,                    Float
  property :holdingsGainPercent,         String
  property :annualizedGain,              String
  property :holdingsGain,                Float
  property :holdingsGainPercentRealtime, String
  property :holdingsGainRealtime,        Float
  property :orderBookRealtime,           String
  property :marketCapitalization,        String
  property :moreInfo,                    String
  property :marketCapRealtime,           Float
  property :eBITDA,                      String
  property :changeFromYearLow,           Float
  property :percentChangeFromYearLow,    String
  property :lastTradeRealtimeWithTime,   String
  property :changePercentRealtime,       String
  property :changeFromYearHigh,          Float
  property :percebtChangeFromYearHigh,   String
  property :lastTradeWithTime,           String 
  property :lastTradePriceOnly,          Float
  property :highLimit,                   Float
  property :lowLimit,                    Float
  property :daysRange,                   String
  property :daysRangeRealtime,           String
  property :fiftydayMovingAverage,       Float 
  property :twoHundreddayMovingAverage,  Float 
  property :changeFromTwoHundreddayMovingAverage, Float
  property :percentChangeFromTwoHundreddayMovingAverage, String
  property :changeFromFiftydayMovingAverage, Float
  property :percentChangeFromFiftydayMovingAverage, String  
  property :name,                        String
  property :open,                        Float
  property :previousClose,               Float
  property :pricePaid,                   Float
  property :changeinPercent,             String
  property :priceSales,                  Float
  property :priceBook,                   Float
  property :exDividendDate,              String
  property :pERatio,                     String
  property :dividendPayDate,             String
  property :notes,                       String
  property :pERatioRealtime,             Float
  property :pEGRatio,                    Float
  property :priceEPSEstimateCurrentYear, Float
  property :priceEPSEstimateNextYear,    Float
  property :sharesOwned,                 Float
  property :errorIndicationreturnedforsymbolchangedinvalid, String
  property :shortRatio,                  Float
  property :lastTradeTime,               String
  property :tickerTrend,                 String
  property :oneyrTargetPrice,            Float
  property :volume,                      Integer
  property :holdingsValue,               Float
  property :holdingsValueRealtime,       Float
  property :yearRange,                   String
  property :daysValueChange,             String
  property :daysValueChangeRealtime,     String
  property :stockExchange,               String
  property :dividendYield,               Float
  property :percentChange,               String
  
end

class Ticker
  include DataMapper::Resource
  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  # A DateTime, for any date you might like.
  property :symbol,                      String, :unique => true
  property :index,                       String
end