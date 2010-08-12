Feature: Load financial onformation
  In order to make investment decisions 
  As an investor 
  I want to have a daily report downloaded from the internet

Scenario: DownLoadData for single ticker
  Given I have a connection to the internet and I know what i want to download
  When I start the downloadTicker task
  Then I get the price for that ticker




  
