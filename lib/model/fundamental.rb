# encoding: utf-8
require 'dm-core'
require 'dm-validations'
#
# Holds an income statement for a company released at a
# certain date.
#
class Incomestatement
  include DataMapper::Resource

  property :id,                              Serial    # An auto-increment integer key
  property :created_at,                      DateTime, :required => true # A DateTime, for any date you might like.

  property :FiscalPeriodEndDate,             DateTime, :required => false
  property :PeriodLength,                    String,:length => 10, :required => false
  property :Source,                          String,:length => 10, :required => false
  property :SourceDate,                      String,:length => 10, :required => false
  property :UpdateType,                      String,:length => 10, :required => false
  property :Revenue,                         String,:length => 10, :required => false
  property :OtherRevenueTotal,               String,:length => 10, :required => false
  property :TotalRevenue,                    String,:length => 10, :required => false
  property :CostofRevenueTotal,              String,:length => 10, :required => false
  property :GrossProfit,                     String,:length => 10, :required => false
  property :SellingGeneralAdminExpensesTot,  String,:length => 10, :required => false
  property :ResearchAndDevelopment,          String,:length => 10, :required => false
  property :DepreciationAmortization,        String,:length => 10, :required => false
  property :InterestExpenseOrIncomeNetOper,  String,:length => 10, :required => false
  property :UnusualExpenseOrIncome,          String,:length => 10, :required => false
  property :OtherOperatingExpensesTotal,     String,:length => 10, :required => false
  property :OperatingIncome,                 String,:length => 10, :required => false
  property :InterestIncomeOrExpNetNonOpera1, String,:length => 10, :required => false
  property :GainOrLossonSaleofAssets,        String,:length => 10, :required => false
  property :OtherNet,                        String,:length => 10, :required => false
  property :NetIncomeBeforeTaxes,            String,:length => 10, :required => false
  property :ProvisionforIncomeTaxes,         String,:length => 10, :required => false
  property :NetIncomeAfterTaxes,             String,:length => 10, :required => false
  property :MinorityInterest,                String,:length => 10, :required => false
  property :EquityInAffiliates,              String,:length => 10, :required => false
  property :USGAAPAdjustment,                String,:length => 10, :required => false
  property :NetIncomeBeforeExtraItems,       String,:length => 10, :required => false
  property :TotalExtraordinaryItems,         String,:length => 10, :required => false
  property :AccountingChange,                String,:length => 10, :required => false
  property :NetIncome   ,                    String,:length => 10, :required => false
  property :TotalAdjustmentstoNetIncome,     String,:length => 10, :required => false
  property :PreferredDividends,              String,:length => 10, :required => false
  property :GeneralPartnersDistributions,    String,:length => 10, :required => false
  property :BasicWeightedAverageShares,      String,:length => 10, :required => false
  property :BasicEPSExcludingExtraordinary,  String,:length => 10, :required => false
  property :BasicEPSIncludingExtraordinary,  String,:length => 10, :required => false
  property :DilutedWeightedAverageShares,    String,:length => 10, :required => false
  property :DilutedEPSExcludingExtraOrdIte,  String,:length => 10, :required => false
  property :DilutedEPSIncludingExtraOrdIte,  String,:length => 10, :required => false
  property :DPSCommonStockPrimaryIssue,      String,:length => 10, :required => false
  property :DividendsperShareComStockIssue,  String,:length => 10, :required => false
  property :GrossDividendsCommonStock,       String,:length => 10, :required => false
  property :InterestExpenseSupplemental,     String,:length => 10, :required => false
  property :DepreciationSupplemental,        String,:length => 10, :required => false
  property :NormalizedEBITDA,                String,:length => 10, :required => false
  property :NormalizedEBIT,                  String,:length => 10, :required => false
  property :NormalizedIncomeBeforeTaxes,     String,:length => 10, :required => false
  property :NormalizedIncomeAfterTaxes,      String,:length => 10, :required => false
  property :NormalizedIncAvailtoCom,         String,:length => 10, :required => false
  property :BasicNormalizedEPS,              String,:length => 10, :required => false
  property :DilutedNormalizedEPS,            String,:length => 10, :required => false
  property :AmortofAcquisitionCostsSupplem,  String,:length => 10, :required => false
  property :AmortofIntangiblesSupplemental,  String,:length => 10, :required => false


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