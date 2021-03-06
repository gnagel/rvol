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
  property :symbol,        String, :required => true,:unique=>true
  property :created_at,    DateTime, :required => true  # A DateTime, for any date you might like.
  property :price,         String, :required => true    # l1 Last Trade (Price Only)
  property :avolume,       String, :required => true    # a2 average volume
  property :volume,        String, :required => true    # v volume
  property :name,          String  # n name
  property :exdividenddate,Date,   :required => false   # q Ex-Dividend Date
  property :dividendyield, String, :required => false # y Dividend Yield
  property :dpershare,     String, :required => false # d Dividend/Share
  property :shortratio,    Float,  :required => false  # s7 shortratio

  property :std20, Float, :required => false
  property :std10, Float, :required => false
  property :std5,  Float, :required => false

  property :analystRatio, Float, :required => false # average buy/sell ratio from analysts 1 best 5 worst


  #
  #
  #
  def parseDate(date)
      dateO = nil
      if date.length == 6
        month = date[0..2]
        day = date[4..6]
        year = DateTime.now.year
        dateS = month+','+day.to_s+','+year.to_s
        dateO = Date.strptime(dateS, '%b,%d,%Y')
      end
      if date.length == 9
        dateO = Date.strptime(date, '%d-%b-%y')
      end
      if date.length == 3
        # this is the N/A
      end
    self.exdividenddate = dateO;
  end
end
