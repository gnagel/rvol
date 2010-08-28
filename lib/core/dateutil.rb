
class DateUtil
  # will find the amount of days to the 3rd friday of the month month is given
  # in the form 2010-07
  def DateUtil.getThirdWeek(date)

  yearmonth =  date.split('-')
 
  year = yearmonth[0]
  month = yearmonth[1]
 
   
     array = month.split(//)
     if array[0]=='0'
      month = array[1]
    end
  daysInMonth = self.days_in_month(year.to_i,month.to_i)
  
  date = Date.new(year.to_i,month.to_i,daysInMonth)
  dateNow = DateTime.now
  # iterate from today to the 3rd week of the month
  fridays = 0
  daysToExpiry = 0
  if dateNow.month == date.month && dateNow.year == date.year
    return self.daysToExpiryThisMonth
  end
  (dateNow..date).each { |day|
   daysToExpiry+=1
    
      value = day.month
      
      if value.to_i == month.to_i
      
        # if friday add up
        if day.cwday.to_i == 5
          fridays+=1
          if fridays == 3
            #puts 'these options expire on: '+day.to_s
         
            break 
          end
        end
      end
  }
  daysToExpiry
  end

def DateUtil.days_in_month(year, month)
  (Date.new(year, 12, 31) << (12-month)).day
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
            puts 'this month options expire on: '+day.to_s
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

def DateUtil.nextMonth(date)
 
  date = Date.new(date.year,date.month+1,date.day)
  
end

end
  

 