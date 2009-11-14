module Blackjack
  class Deck
    attr_reader :cards
    
    def initialize
      @cards = []
      4.times do
        CARDS.each do |card|
          @cards << card
        end
      end
      
      @cards = @cards.sort_by { rand }
    end
  end
end