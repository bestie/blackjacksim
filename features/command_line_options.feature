Feature: Command line options
  As a user
  I want to start the simulator with different options
  So that I can better evaluate my strategies
  
  Background:
    Given I have a strategy

  Scenario: Start simulator with no options
    When I initialise the simulator with no options
    Then I should the help message
    And I should not see "No strategy file provided"
  
  Scenario Outline: Play n hands
    When I initialise the simulator with a valid file and <options>
    And the simulator starts
    Then I should see "Simulating <n> hands"
    And I should see <n> game results
    And I should see a results summary
    Examples:
      | n   | options                 |
      | 20  | "--number-of-hands 20"  |
      | 20  | "-n 20"                 |
      | 100 | "--number-of-hands 100" |
      | 100 | "-n 100"                |
      | 200 | "--number-of-hands 200" |
      | 200 | "-n 200"                |
  
  Scenario Outline: Play n hands
    When I initialise the simulator with options <options>
    Then I should see usage instructions
    Examples:
      | options  |
      | "-h"     |
      | "--help" | 