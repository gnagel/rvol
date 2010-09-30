puts 'fuck you'

strikes = [ 12, 13, 14, 15, 16,17, 18, 19 , 20 , 21]

lastPrice = 16

closest4 = Array.new

strikes.each { |e|  
 value= (lastPrice-e).abs
closest4.push value
}
p 'result'
#puts closest4
puts closest4.min
