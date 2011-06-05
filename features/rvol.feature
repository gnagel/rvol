Feature: Using rvol
  In order to use the application
  As an investor
  I want to have a command line application with options and help on using them

#
#
#
Scenario: Run rvol
  Given I run rvol
  Then I should see "Usage: rvol [options]"
  And I should not see "command not found"
#
#
#
Scenario: Run rvol
  Given I run "rvol -p"
  Then I should see: "Report_Name"
  And I should see: "Report_Description"