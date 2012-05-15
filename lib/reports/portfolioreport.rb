# encoding: utf-8
require 'model/stock'
require 'model/portfolio'
require 'model/stockdaily'
require 'reports/report'
#
# Report on stocks in the portfolio. This report will check for price changing factors like
# earnings, dividends, and news and form a readable report for the investor.
#
class PortfolioReport < Report
  #
  # Generate report for
  #
  def generateReportArgs(args)
    portfolio = Array.new
    args.each do |ticker|
      portfolio << Portfolio.create(:ticker=>ticker)
    end
    # Load Dividends day
    # Check if earnings in the next month

    # 1. get earnings
      portfolio.each do |port|
       earning = Earnings.first(:ticker=>port.ticker)
       if earning != nil
        port.earningsDate = earning.date
       end
    # 2 get dividends
        port.dividendsDate =  Stockdaily.first(:symbol=>port.ticker).exdividenddate
      end
    # 3. Get ratingss
          # nothing to get
    # 4. Ger news
  end

  #
  # Used to print a genereic info of the report.
  #
  def printInfo
    'this method should explain the report in plain english implement me'
  end

  #
  # Prints the chains for a single month
  #
  # Portfolio # Earnings this month # Dividends # Ratings # News #
  #   AAPL          13th Jan             15 Dec     10

  def printReport(chains)

    table = Table(%w[Portfolio Earnings? Dividends Rating News])
    chains.each { |elem|
      table << [elem.type, elem.ticker ]
    }
    print table
    puts addVol(chains)
    puts addOpenInt(chains)
  end

end