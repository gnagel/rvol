# encoding: utf-8
require 'helper'
require 'scrapers/scraper'
require 'test/unit'

class Test_scraper  < Test::Unit::TestCase
  def test_yahoo_csv

    hydra = Typhoeus::Hydra.new
    request = Scraper.downLoadYahooCSV('AAPL')
    request.on_complete { | response |
      debugResponse(response)
    }
    hydra.queue(request)
    hydra.run
  end

  def test_wikipedia
    request = Scraper.downLoadSP500WikiPedia

  end

  def test_sp500Yahoo
    response = Scraper.downLoadSP500Yahoo('1')
  end

  def test_downloadHistory
    hydra = Typhoeus::Hydra.new
    request = Scraper.downLoadHistory('GOOG')
    request.on_complete { | response |
      puts response.body
      debugResponse(response)
    }
    hydra.queue(request)
    hydra.run
  end

  def test_downloadScouterTop50
    response = Scraper.downLoadStockScouterTop50
    debugResponse(response)
  end

  def test_downLoadStockScouter10
    response = Scraper.downLoadStockScouter10
    debugResponse(response)
  end
  
  def test_downLoadStockScouterTop1050
    response = Scraper.downLoadStockScouterTop1050
    debugResponse(response)
  end 
  
  def test_downLoadStockScouterTop10100
    response = Scraper.downLoadStockScouterTop10100
    debugResponse(response)
  end 
  
  def test_downLoadStockScouterTop150
    response = Scraper.downLoadStockScouterTop150
    debugResponse(response)
  end
  
  def test_downLoadStockScouterTop1100
    response = Scraper.downLoadStockScouterTop1100
    debugResponse(response)
  end
  
  
  def test_downLoadETF100
    response = Scraper.down100VolETF
    debugResponse(response)
  end

  def test_downLoadCapsFool
    responses = Scraper.downloadFoolTop510
    responses.each do |response|
      debugResponse(response)
    end
  end

  def debugResponse(response)
    assert_equal(200,response.code,"Didnt return 200 failed")
    puts response.code    # http status code
    puts response.time    # time in seconds the request took
    puts response.headers # the http headers
    puts response.headers_hash # http headers put into a hash
    #puts response.body
  end
end