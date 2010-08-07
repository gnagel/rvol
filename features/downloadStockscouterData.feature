Feature: Download data from stock scouter
    In order to analyse market data 
    As an data storage server
    I want to download market data to be analysed
  
    Scenario: Download stock scouter top 10 data
		Given i can connect to the stockscouter site
		And can download the content from there
		When startDownload
      Then I should get a list of 10 stocks 
	  
	 Scenario: Download stock scouter top 50 data
		Given i can connect to the stockscouter site
		And can download the content from there
		When startDownload
      Then I should get a list of 50 stocks

	 Scenario: Download stock scouter bottom 50 data
		Given i can connect to the stockscouter site
		And can download the content from there
		When startDownload
      Then I should get a list of 50 stocks
	  
	  
		