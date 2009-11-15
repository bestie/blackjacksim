Feature: Basic game simulation
  As a user
  I want to simulate many hands of blackjack
  So that I can evaluate my strategy

  Background:
    Given I have a strategy
    
  Scenario: Start simulator with valid strategy file
    When I initialise the simulator with a valid file
    And the simulator starts
    Then I should see "Simulating 10 hands"
    And I should see "Bank roll 100 chips"
    And I should see 10 game results
    And I should see a results summary
    
  Scenario: Player is very lucky and always wins
    When I initialise the simulator with a valid file
    Given the player wins all hands
    When the simulator starts
    Then I should see "Simulating 10 hands"
    And I should see 10 "WIN" results
    And I should see "Wins: 10"
    And I should see "Losses: 0"
    And I should see "Profit: 10"
    
  Scenario: Player is on a losing streak, dealer always wins
    When I initialise the simulator with a valid file
    Given the player loses every hand
    When the simulator starts
    Then I should see "Simulating 10 hands"
    And I should see 10 "LOSE" results
    And I should see "Wins: 0"
    And I should see "Losses: 10"
    And I should see "Profit: -10"
    
  Scenario: Player and dealer are equally lucky
    When I initialise the simulator with a valid file
    Given the player and dealer win equal hands
    When the simulator starts
    Then I should see "Simulating 10 hands"
    And I should see 5 "LOSE" results
    And I should see 5 "WIN" results
    And I should see "Wins: 5"
    And I should see "Losses: 5"
    And I should see "Profit: 0"
    
  Scenario: Player plays until bankrupt
    When I initialise the simulator with a valid file and "-n 101"
    Given the player loses every hand
    When the simulator starts
    Then I should see "Simulating 101 hands"
    And I should see 101 "LOSE" results
    And I should see "GAME OVER Player bankrupt"