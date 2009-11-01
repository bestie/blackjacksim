Feature: User starts simulation
  As a user
  I want to simulate many hands of blackjack
  So that I can evaluate my strategy
  
  Scenario: start sim
    Given I have a strategy
    When I start the simulator
    Then I should see the results
    