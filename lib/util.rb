
class Util
  # will find the amount of days to the 3rd friday of the month month is given
  # in the form 2010-07
  def get3rdWeek(date)

  yearmonth =  date.split('-')
 
  year = yearmonth[0]
  month = yearmonth[1]
 
  date = Date.new(Integer(year),Integer(month),Integer(30))
  dateNow = DateTime.now
  # iterate from today to the 3rd week of the month
  fridays = 0
  daysToExpiry = 0
  (dateNow..date).each { |day|
   daysToExpiry+=1
    
      value = day.month
      
      if value.to_i == month.to_i
      
        # if friday add up
        if day.cwday.to_i == 5
          fridays+=1
          if fridays == 3
            puts 'these options expire on: '+day.to_s
         
            break 
          end
        end
      end
  }
  daysToExpiry
  end

  
end