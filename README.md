# Blackjacksim v0.1

Blackjacksim is a command line tool designed to help evaluate playing strategies given in the form of a CSV file.

It is not an interactive game.

Output at the end of each simulation shows:

* Hands won
* Hands lost
* Total profit (negative amount for loss)

The aim is to be as close to a casino blackjack game as possible and the following features have been implemented to achieve this:

* The shoe contains six decks of cards
* Only 50% - 80% of the shoe is dealt before it is discarded, refilled and reshuffled
* Dealer always stands on 17
* Blackjack pays 3 to 2

-------------------------------------------------------------------------------

## Usage

From project root:

    $ bin/blackjacksim <strategy CSV> [--number-of-hands ...]

-------------------------------------------------------------------------------

## Still to implement

* Player should be able to split pairs and double down
* Better stats / reporting
* Card counting and probability calculations
* More command line options for verbosity, number of decks, units of credit in player's blank roll
