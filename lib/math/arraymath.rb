#
# Statistical methods for array
#
class Array
  def closest int
    diff = int-self[0]; best = self[0]
    each {|i|
      if (int-i).abs < diff.abs
        best = i; diff = int-i
      end
    }
    best
  end

  def sum
    inject( nil ) { |sum,x| sum ? sum+x : x }
  end

  def mean
    sum=0
    self.each {|v| sum += v}
    sum/self.size.to_f
  end

  def variance
    m = self.mean
    sum = 0.0
    self.each {|v| sum += (v-m)**2 }
    sum/self.size
  end

  def stdev
    Math.sqrt(self.variance)
  end

  def count                                 # => Returns a hash of objects and their frequencies within array.
    k=Hash.new(0)
    self.each {|x| k[x]+=1 }
    k
  end

  def ^(other)                              # => Given two arrays a and b, a^b returns a new array of objects *not* found in the union of both.
    (self | other) - (self & other)
  end

  def freq(x)                               # => Returns the frequency of x within array.
    h = self.count
    h(x)
  end

  def maxcount                              # => Returns highest count of any object within array.
    h = self.count
    x = h.values.max
  end

  def mincount                              # => Returns lowest count of any object within array.
    h = self.count
    x = h.values.min
  end

  def outliers(x)                           # => Returns a new array of object(s) with x highest count(s) within array.
    h = self.count
    min = self.count.values.uniq.sort.reverse.first(x).min
    h.delete_if { |x,y| y < min }.keys.sort
  end

  def zscore(value)                         # => Standard deviations of value from mean of dataset.
    (value - mean) / stdev
  end

  def covariance(other)
    ab = Array.new()
    self.each_with_index {|x, i| ab << (x * other[i])}
    ab.mean - self.mean * other.mean
  end

  def correlation(other)
    self.covariance(other) / Math.sqrt(self.variance * other.variance)
  end

  #
  # chunks the array into  peaces
  #
  def chunk(pieces=2)
    if(pieces!=0)
      len = self.length;
      mid = (len/pieces)
      chunks = []
      start = 0
      1.upto(pieces) do |i|
        last = start+mid
        last = last-1 unless len%pieces >= i
        chunks << self[start..last] || []
        start = last+1
      end
      chunks
    else
      self
    end
  end

end