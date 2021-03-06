# encoding: utf-8
require 'date'
#
# Utility class with date methods for options.
#
class DateUtil
  #
  # will find the amount of days to the 3rd friday of the month month is given
  # in the form 2010-07
  #
  def DateUtil.getDaysToExpFriday(date)
    daysInMonth = self.days_in_month(date.year, date.month)
    date = Date.new(date.year, date.month, daysInMonth)
    dateNow = DateTime.now
    fridays = 0
    daysToExpiry = 0

    if dateNow.month == date.month && dateNow.year == date.year
      return DateUtil.daysToExpiryThisMonth
    end

    # iterate from today to the 3rd week of the month
    (dateNow..date).each { |day|
      daysToExpiry+=1

      value = day.month

      if value.to_i == date.month.to_i

        # if friday add up
        if day.cwday.to_i == 5
          fridays+=1
          if fridays == 3
            break
          end
        end
      end
    }
    daysToExpiry
  end

  #
  # finds the expiry date in this month
  #
  def DateUtil.fridayFinder(year, month)
    date = Date.new(year, month, 1)
    date2 = Date.new(date.year, date.month, days_in_month(date.year, date.month))
    # iterate from today to the 3rd week of the month
    fridays = 0
    daysToExpiry = 0
    (date..date2).each { |day|
      daysToExpiry+=1

      # if friday add up
      if day.cwday.to_i == 5
        fridays+=1
        if fridays == 3

          break
        end
      end

    }
    daysToExpiry
  end

  #
  # Finds how many days to expity in this month
  #
  def DateUtil.daysToExpiryThisMonth
    date = DateTime.now
    date2 = Date.new(date.year, date.month, self.fridayFinder(date.year, date.month))
    # iterate from today to the 3rd week of the month
    fridays = 0
    daysToExpiry = 0
    (date..date2).each { |day|
      daysToExpiry+=1

    }
    daysToExpiry
  end

  #
  # Returns days in the month
  #
  def DateUtil.days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end

  #
  # Returns the next month date
  #
  def DateUtil.nextMonth(date)
    date >> 1
  end

  #
  # parse to the format used in the scrapers
  #
  def DateUtil.dateParsed(date)
    date.strftime("%Y-%m")
  end

  #
  # Generate the option symbol from the date for  the front month. If the date is past expiry give next month
  #
  def DateUtil.getOptSymbThisMonth(ticker)
    ticker = DateUtil.tickerSlicer(ticker)
    date = DateTime.now
    expDay = DateUtil.fridayFinder(date.year, date.month) + 1
    date = Date.new(date.year, date.month, expDay)

    if (DateUtil.getDaysToExpFriday(date)==0)
      # get next month expiry gone already this month
      date = date >> 1
      expDay = DateUtil.fridayFinder(date.year, date.month) + 1
      date = Date.new(date.year, date.month, expDay)
    end

    oticker = ticker+date.strftime("%y%m%d")
  end

  #
  # Generate the option symbol from the date for the back month. If the date is past expiry give next month
  #
  def DateUtil.getOptSymbNextMonth(ticker)
    ticker = DateUtil.tickerSlicer(ticker)
    date = DateTime.now

    if (DateUtil.getDaysToExpFriday(date)==0)
      # get next month expiry gone already this month

      date = date >> 2

      expDay = DateUtil.fridayFinder(date.year, date.month) + 1
      date = Date.new(date.year, date.month, expDay)
    else
      # use next
      date = date >> 1
      expDay = DateUtil.fridayFinder(date.year, date.month) + 1
      date = Date.new(date.year, date.month, expDay)
    end

    oticker = ticker+date.strftime("%y%m%d")
  end

  #
  # Parse the options expiry month from the opt symbol
  #
  def DateUtil.getDateFromOptSymbol(ticker, optSymbol)

    begin
      ## remove ^ from front if exists
      sliced = DateUtil.tickerSlicer(ticker)
      ##remove ticker from front
      if optSymbol.include? sliced
        parsed1 = optSymbol.delete sliced
        ## get next 4 yymm
        parsed2 = parsed1[0..5]
        date = Date.strptime(parsed2, "%y%m%d")
        return date
      end
    rescue Exception => e
      puts 'failed date for ' + ticker + ' ' +optSymbol
      puts e
      return 'N/A'
    end
  end

  def DateUtil.tickerSlicer(ticker)
    if (ticker.slice(0)=='^')
      sliced = ticker[1..-1]
    else
      sliced = ticker
    end
    sliced
  end

  #
  # Get the string for next frifay in the for yymmdd
  #
  def self.getFridayDateStr
    date = Time.now
    one_day = 60 * 60 * 24
    while date.wday!=5 do
      date += one_day
    end
    date.strftime("%y%m%d")
  end
    #
  # Get the string for next frifay in the for yymmdd
  #
  def self.getFridayDateStr2
    date = Time.now
    one_day = 60 * 60 * 24
    while date.wday!=4 do
      date += one_day
    end
    date.strftime("%y%m%d")
  end

end

