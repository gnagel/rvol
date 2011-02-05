# encoding: utf-8
#
# General class for whatever util methods
#
class Util
  #
  # Try to remove a "," from a number for instance: 1,2443 will bebome 12443
  #
  def self.removeComma(str)
    begin
      if(str.include?',')
        return str.gsub(/\,/,"").to_i
      end
    rescue => boom
      puts 'error:  ' + boom.to_s
    end
    str.to_i
  end

  def self.toFloat(str)
    begin
      return str.to_f
    rescue => boom
      puts 'error:  ' + boom.to_s
    end
    0
  end
end