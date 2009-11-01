module Blackjack
  class Shoe

    def initialize(decks)
      @cards = []
      decks.times do
        deck = Deck.new
        deck.cards.each do |card|
          @cards << card
        end
      end
    end
    
    def count
      @cards.length
    end
    
    def deal
      @cards.pop
    end    
  end
end