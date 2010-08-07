Feature: Download earnings
	In order to handle earnings 
	As an investor 
	I want a list of the coming earnings for the next 30 days

    Scenario: Download earnings report
	  Given i am connected to the internet
	  When i call downloadEarnings
	  Then I get a list of coming earnings for the next month
	
	Scenario: Attach chains information to earnings
	  Given I have a list of earnings
	  When i call attachChains
	  Then I get a list of chains for the companies in the earnings report
	
	Scenario: Calculate front volatility versus back volatility for 2 months and 1 year
	  Given I i have a company i want skew information
	  When i call calculateSkews
	  Then I get a list of skews for the company
