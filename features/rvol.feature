Feature: Load financial information
  In order to make investment decisions 
  As an investor 
  I want to have access to all financial information on my computer

# Dont test  
#Scenario: DownLoad market snapsot
#  Given I am on the internet
#  When I press startDownload snapsot
#  Then The system downloads a snapshot of the current market situation.
  
Scenario: View earnings report
  Given I have a market snapshot 
  When I call view earnings report 
  Then The system displays a list of earnings for the next month with front month and back month earnings
#
# Note: The news are a rss from google finance for now
#
Scenario: View news for a particular ticker
  Given I have a market snapshot 
  When I want to view news for a ticker 
  Then The system shows the most current news for a ticker with links.




  
