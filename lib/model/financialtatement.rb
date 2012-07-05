# encoding: utf-8
require 'dm-core'
require 'dm-validations'
#
# Holds an income statement for a company released at a
# certain date.
#
class Incomestatement
  include DataMapper::Resource

  property :id,                           Serial    # An auto-increment integer key
  property :created_at,                   DateTime, :required => true # A DateTime, for any date you might like.
  property :TotalRevenue,                 Float, :required => false
  property :CostofRevenueTotal,           Float, :required => false
  property :GrossProfit,                  Float, :required => false
  property :SellingTotal,                 Float, :required => false
  property :ResearchDevelopment ,         Float, :required => false
  property :TotalOperatingExpense ,       Float, :required => false
  property :OperatingIncome ,             Float, :required => false
  property :IncomeBeforeTax ,             Float, :required => false
  property :IncomeAfterTax   ,            Float, :required => false
  property :NetIncome      ,              Float, :required => false
  property :DilutedWeightedAverageShares, Float, :required => false
  property :DilutedEPS,                   Float, :required => false
  property :DividendsperShare ,           Float, :required => false
  property :DilutedNormalizedEPS,         Float, :required => false
end

#
# Holds a balance sheets for an instrument for the past years
#
class BalanceSheet

end

#
# Holds the cash flow statement for an instrument for past years
#
class CashFlow

end