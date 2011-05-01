# encoding: utf-8
require 'dm-core'
require 'dm-validations'
#
# Holds the current portfolio
#
class Portfolio
  include DataMapper::Resource

  #Portfolio # Earnings this month # Dividends # Ratings # News #
  property :id,                          Serial    # An auto-increment integer key
  property :created_at,                  DateTime, :required => true # A DateTime, for any date you might like.
  property :ticker,                      String, :required => true
  property :earningsDate,                Date,   :required => false
  property :dividendsDate,               String, :required => false
  property :rating,                      String, :required => false
  def initialize(ticker)
    self.created_at = Time.now
    self.symbol=ticker
  end
  
  def toString
    puts self.inspect
  end

end