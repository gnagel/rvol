Feature: Report
  In order to make investment decisions 
  As an investor 
  I want to have a daily report downloaded from the internet

Scenario: Generate a report
  Given i have downloaded data for the day
  When I start the generate report task
  Then I get a PDF report for the day




  
