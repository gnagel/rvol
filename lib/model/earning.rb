require 'dm-core'
require 'dm-validations'

class Earning
  include DataMapper::Resource

  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime  # A DateTime, for any date you might like.
  property :date,                        String
  property :ticker,                      String
  property :frontMonth,                  String
  property :backMonth,                   String
  
  def initialize(date,ticker)
    self.date = date
    self.ticker = ticker
    self.created_at = Time.now
  end


end