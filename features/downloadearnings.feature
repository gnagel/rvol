Feature: Download earnings
	In order to handle earnings 
	As an investor 
	I want a list of the coming earnings for the next 30 days

    Scenario: Download earnings report
	  Given i am connected to the internet
	  When i call downloadEarnings
	  Then I get a list of coming earnings for the next month

