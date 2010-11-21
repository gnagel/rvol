require 'date'
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'model/earning'
require "scrapers/optionschainsscraper"
require "core/dateutil"
require 'typhoeus'

class EarningsScraper

  #
  # Generally, you should be running requests through hydra. Here is how that looks  
  #
  def EarningsScraper.getEarningsMonth2(filter)
    hydra = Typhoeus::Hydra.new(:max_concurrency => 20)

    t = DateTime.now
    t.step(t+30,step=1) { | n |
      date = n.strftime("%Y%m%d")

      url="http://biz.yahoo.com/research/earncal/"+date+".html"
      puts url
      request = Typhoeus::Request.new(url)

      request.on_complete { | response |
        begin
          if(response.code==200)
            puts 'success 200'
         
            doc = Hpricot(response.body)
            chains = (doc/"//a[@href]")
          
            for obj in chains

              if obj.to_html.include? "http://finance.yahoo.com/q?"
                ticker = obj.inner_text
                puts obj.inner_text
                if filter.include?(ticker)
                  earning = Earning.new(date,ticker)
                  boolea = earning.save
                  puts 'SAVE:' +boolea.to_s
                end
              end

            end
          else
            puts 'failed'
            puts response.code
            #puts response.body
          end
        rescue => boom
          puts 'failed for date' +date
          puts boom
        end
      } 
      hydra.queue(request)
    }
    p 'starting hydra'
    hydra.run
    p 'hydra done'

  end

end
