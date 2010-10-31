#
# Utility class to find dates in options cycles
#
class DateUtil

  # 
  # will find the amount of days to the 3rd friday of the month month is given
  # in the form 2010-07
  #
  def DateUtil.getDaysToExpFriday(date)

  daysInMonth = self.days_in_month(date.year,date.month)  
  date = Date.new(date.year,date.month,daysInMonth)
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
  
  def DateUtil.fridayFinder(year, month)
    date = Date.new(DateTime.now.year,DateTime.now.month,1)
    date2 = Date.new(date.year,date.month,days_in_month(date.year,date.month))
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

  def DateUtil.daysToExpiryThisMonth
    date = DateTime.now
    date2 = Date.new(date.year,date.month,self.fridayFinder(date.year, date.month))
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
  if(date.month!=12)
  date = Date.new(date.year,date.month+1,1)
  else
    date = Date.new(date.year+1,1,1)
  end
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
  date = DateTime.now
  if(DateUtil.getDaysToExpFriday(date)==0)
  date = Date.new(date.year,date.month+1,1)
  end  
  
  oticker = ticker+date.strftime("%y%m")
end

#
# Generate the option symbol from the date for the back month. If the date is past expiry give next month
#
def DateUtil.getOptSymbNextMonth(ticker)
  date = DateTime.now
  if(DateUtil.getDaysToExpFriday(date)==0)
  date = Date.new(date.year,date.month+1,1)
  end
  date = DateUtil.nextMonth(date)
  oticker = ticker+date.strftime("%y%m")
end

#
# Parse the options expiry month from the opt symbol
#
def DateUtil.getDateFromOptSymbol(ticker,optSymbol)
  begin
  ##remove ticker from front
  parsed1 = optSymbol.delete ticker
  ## get next 4 yymm
  parsed2 = parsed1[0..3]
  return Date.strptime(parsed2,"%y%m")
  
  rescue Exception => e
    puts 'failed date'
    puts ticker
    puts optSymbol
    return 'N/A'
  end
end  

end
  

 