# encoding: utf-8
require 'date'
require 'open-uri'
require 'nokogiri'
require 'model/earning'
require "scrapers/optionschainsscraper"
require "core/dateutil"
require 'typhoeus'

#
# Load earnings for coming month
#
class EarningsScraper
  #
  # Load all earnings
  #
  def getEarningsMonth2(test=false)
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
    days = 30
    if test
      days = 2
    end
    t = DateTime.now
    t.step(t+days, step=1) { |n|
      date = n.strftime("%Y%m%d")
      url="http://biz.yahoo.com/research/earncal/"+date+".html"

      request = Typhoeus::Request.new(url, :timeout=>10000)
      request.on_complete { |response|
        begin
          if (response.code==200)
            puts 'HTTP RESPONSE: 200 for Date: '+date
            doc = Nokogiri::HTML(response.body)
            chains = doc.search("//a[@href]")
            for obj in chains
              if obj.to_html.include? "http://finance.yahoo.com/q?"
                ticker = obj.inner_text
                # no filtering
                #if filter.include?(ticker)
                earning = Earning.new(date, ticker)
                boolean = earning.save
              end
            end
          else
            puts 'HTTP RESPONSE: '+response.code.to_s
            #puts response.body
          end
        rescue => boom
          puts 'failed for date ' +date
          puts boom
        end
      } # end request
      hydra.queue(request)
    }
    hydra.run
  end
end
