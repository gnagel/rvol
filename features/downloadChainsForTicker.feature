Feature: download chains for ticker
  In order to download options chains from yahoo
  As a user I want to be able to download options data for symbols. 

  Scenario: Download list of options chains from yahoo 
    Given there is a connection to the internet available 
    And i have given the ticker name
    When I downloadAll chains for a given ticker
    Then I should get a set of options chains containing all chains for that ticker