# encoding: utf-8
require 'reports/report'
require 'model/stockcorrelation'
#
# Different correlation reports
#
class CorrelationReport < Report

  #
  # print the report
  #
  def generateReport
    matches = Calculatecorrelations.new.getCorrelationIrregularity
    table = Table(%w[Symbol1 Symbol2 CORRELATION])
    matches.each do |cor|
      begin
        table <<[cor.symbol,cor.symbol2,cor.correlation]
      rescue => error
        puts error
      end
    end
    print table
  end

  def printInfo
    'A report for instruments with irregular correlation compared to a high long term correlation'
  end

end

class CorrelatedStocks < Report

  #
  # print the report
  #
  def generateReportArgs(args)

    puts "Stocks correlated with #{args}"
    matches =  Calculatecorrelations.new.getCorrelatedStocks(args)

    table = Table(%w[Symbol1 Symbol2 CORRELATION])
    matches.each do |cor|
      begin
        table <<[cor.symbol,cor.symbol2,cor.correlation]
      rescue => error
        puts error
      end
    end
    print table
  end

  def printInfo
    'A report for instruments which are highly correlated with the given ticker'
  end

end