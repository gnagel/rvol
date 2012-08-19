# encoding: utf-8
require 'scrapers/scraper'
require 'nokogiri'
require 'model/fundamental'
#
# Scrapes fundamental data from msn
#
class Fundamentalscraper

  def parseIncomeStatement(symbol,type='ann')
       if type == 'ann'
         response = Scraper.new.downloadIncomeStamentMSNANN(symbol)
       else if type == 'qtr'
         response = Scraper.new.downloadIncomeStamentMSNQTR(symbol)
            end
       end
       doc = Nokogiri::HTML(response.body)
       income1 = Incomestatement.new
       income2 = Incomestatement.new
       income3 = Incomestatement.new
       income4 = Incomestatement.new
       income5 = Incomestatement.new

       parseField('id="FiscalPeriodEndDate"',doc,income1,income2,income3,income4,income5)
       parseField('id="PeriodLength"',doc,income1,income2,income3,income4,income5)
       parseField('id="Source"',doc,income1,income2,income3,income4,income5)
       parseField('id="SourceDate"',doc,income1,income2,income3,income4,income5)
       parseField('id="UpdateType"',doc,income1,income2,income3,income4,income5)
       parseField('id="Revenue"',doc,income1,income2,income3,income4,income5)
       parseField('id="OtherRevenueTotal"',doc,income1,income2,income3,income4,income5)
       parseField('id="TotalRevenue"',doc,income1,income2,income3,income4,income5)
       parseField('id="CostofRevenueTotal"',doc,income1,income2,income3,income4,income5)
       parseField('id="GrossProfit"',doc,income1,income2,income3,income4,income5)
       parseField('id="SellingGeneralAdminExpensesTot"',doc,income1,income2,income3,income4,income5)
       parseField('id="ResearchAndDevelopment"',doc,income1,income2,income3,income4,income5)
       parseField('id="DepreciationAmortization"',doc,income1,income2,income3,income4,income5)
       parseField('id="InterestExpenseOrIncomeNetOper"',doc,income1,income2,income3,income4,income5)
       parseField('id="UnusualExpenseOrIncome"',doc,income1,income2,income3,income4,income5)
       parseField('id="OtherOperatingExpensesTotal"',doc,income1,income2,income3,income4,income5)
       parseField('id="OperatingIncome"',doc,income1,income2,income3,income4,income5)
       parseField('id="InterestIncomeOrExpNetNonOpera1"',doc,income1,income2,income3,income4,income5)
       parseField('id="GainOrLossonSaleofAssets"',doc,income1,income2,income3,income4,income5)
       parseField('id="OtherNet"',doc,income1,income2,income3,income4,income5)
       parseField('id="NetIncomeBeforeTaxes"',doc,income1,income2,income3,income4,income5)
       parseField('id="ProvisionforIncomeTaxes"',doc,income1,income2,income3,income4,income5)
       parseField('id="NetIncomeAfterTaxes"',doc,income1,income2,income3,income4,income5)
       parseField('id="MinorityInterest"',doc,income1,income2,income3,income4,income5)
       parseField('id="EquityInAffiliates"',doc,income1,income2,income3,income4,income5)
       parseField('id="USGAAPAdjustment"',doc,income1,income2,income3,income4,income5)
       parseField('id="NetIncomeBeforeExtraItems"',doc,income1,income2,income3,income4,income5)
       parseField('id="TotalExtraordinaryItems"',doc,income1,income2,income3,income4,income5)
       parseField('id="AccountingChange"',doc,income1,income2,income3,income4,income5)
       parseField('id="NetIncome"',doc,income1,income2,income3,income4,income5)
       parseField('id="TotalAdjustmentstoNetIncome"',doc,income1,income2,income3,income4,income5)
       parseField('id="PreferredDividends"',doc,income1,income2,income3,income4,income5)
       parseField('id="GeneralPartnersDistributions"',doc,income1,income2,income3,income4,income5)
       parseField('id="BasicWeightedAverageShares"',doc,income1,income2,income3,income4,income5)
       parseField('id="BasicEPSExcludingExtraordinary"',doc,income1,income2,income3,income4,income5)
       parseField('id="BasicEPSIncludingExtraordinary"',doc,income1,income2,income3,income4,income5)
       parseField('id="DilutedWeightedAverageShares"',doc,income1,income2,income3,income4,income5)
       parseField('id="DilutedEPSExcludingExtraOrdIte"',doc,income1,income2,income3,income4,income5)
       parseField('id="DilutedEPSIncludingExtraOrdIte"',doc,income1,income2,income3,income4,income5)
       parseField('id="DPSCommonStockPrimaryIssue"',doc,income1,income2,income3,income4,income5)
       parseField('id="DividendsperShareComStockIssue"',doc,income1,income2,income3,income4,income5)
       parseField('id="GrossDividendsCommonStock"',doc,income1,income2,income3,income4,income5)
       parseField('id="InterestExpenseSupplemental"',doc,income1,income2,income3,income4,income5)
       parseField('id="DepreciationSupplemental"',doc,income1,income2,income3,income4,income5)
       parseField('id="NormalizedEBITDA"',doc,income1,income2,income3,income4,income5)
       parseField('id="NormalizedEBIT"',doc,income1,income2,income3,income4,income5)
       parseField('id="NormalizedIncomeBeforeTaxes"',doc,income1,income2,income3,income4,income5)
       parseField('id="NormalizedIncomeAfterTaxes"',doc,income1,income2,income3,income4,income5)
       parseField('id="NormalizedIncAvailtoCom"',doc,income1,income2,income3,income4,income5)
       parseField('id="BasicNormalizedEPS"',doc,income1,income2,income3,income4,income5)
       parseField('id="DilutedNormalizedEPS"',doc,income1,income2,income3,income4,income5)
       parseField('id="AmortofAcquisitionCostsSupplem"',doc,income1,income2,income3,income4,income5)
       parseField('id="AmortofIntangiblesSupplemental"',doc,income1,income2,income3,income4,income5)
       income5
  end

  def parseBalanceSheet(symbol,type='ann')

  end

  def parseCashFlow(symbol,type='ann')

  end

  #
  # parse field
  #
  def parseField(fieldName, doc, object1, object2, object3, object4, object5)
    puts 'parsing field '+fieldName
    begin
    doc.xpath("//tr").each do |tr|
      if (tr.to_s.include?(fieldName))
        text1 = tr.xpath("td[2]").inner_text.strip
        text2 = tr.xpath("td[3]").inner_text.strip
        text3 = tr.xpath("td[4]").inner_text.strip
        text4 = tr.xpath("td[5]").inner_text.strip
        text5 = tr.xpath("td[6]").inner_text.strip
        puts text1
        puts text2
        puts text3
        puts text4
        puts text5

        puts 'object field name'
        puts fieldName[4..-2]
        object1.send("#{fieldName[4..-2]}=", text1)
        object2.send("#{fieldName[4..-2]}=", text2)
        object3.send("#{fieldName[4..-2]}=", text3)
        object4.send("#{fieldName[4..-2]}=", text4)
        object5.send("#{fieldName[4..-2]}=", text5)
      end
    end
    rescue => error
      puts 'failed!! ' + error
    end
    puts 'done parsing field '+fieldName
  end
end