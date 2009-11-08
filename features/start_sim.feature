# Feature: User starts simulation
#   As a user
#   I want to simulate many hands of blackjack
#   So that I can evaluate my strategy
#   
#   Background:
#     Given I have a strategy
#     And a bankroll of 100
#     And a player
#     And the shoe has 6 decks
#     
#   Scenario: Player has no money
#     Given the player is bankrupt
#     When I start the a new hand
#     Then 0 cards should be dealt
#     Then I should see "New Hand"
#     And I should see "Game Over: Player bankrupt"
#     
#   Scenario:
#     When I start the a new hand
#     Then the player should have placed a bet
#     And the player should have 2 cards
#     And the dealer should have 2 cards
#     
#     Given the player will hit 1 times and stand
#     When the game continues
#     Then the player should have 2 cards
#   
#         