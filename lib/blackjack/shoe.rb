module Blackjack
  class Shoe

    attr_reader :cards
    
    def initialize(decks)
      @decks = decks
      reset_cards
      
      # the entirety of the shoe is never dealt
      proportion_to_discard = 0.2 + (rand * 0.3)
      @number_to_discard = (count * proportion_to_discard).ceil
    end
    
    def discard_remaining_cards?
      count < @number_to_discard
    end
    
    def count
      @cards.length
    end
    
    def deal
      @cards.pop unless discard_remaining_cards?
    end
    
    def reset_cards
      @cards = []
      @decks.times do
        deck = Deck.new
        deck.cards.each do |card|
          @cards << card
        end
      end
    end
    
  end
end