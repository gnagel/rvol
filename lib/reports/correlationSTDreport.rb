# encoding: utf-8
require 'model/stockcorrelation'

#
# calculates correlations for the past 20 days and stores all into db. The idea is to laod std 20 for each 
# correlation to find instruments where correlation has changed
#
class CorrelationSTDreport
  #
  # Calculate the largest std change in correlations. Take into acccount only pairs that 
  # are higly correlated or highly anticorrelated (move in opposite directions)
  #
  def caclulateStdCorrelation
  
  end 
  

  
  def loadAllCorrelations
    correlations = Stockcorrelation.all(:symbol=>'SPY',:symbol2=>'EWJ')
      correlations.each do |cor|
        puts cor.symbol
        puts cor.symbol2
        puts cor.correlation
      end
  end
    
end