module Blackjack
  class Deck
    attr_accessor :cards
    
    def initialize
      self.cards = []
      4.times do
        CARDS.each do |card|
          self.cards << card
        end
      end
      
      self.cards = self.cards.sort_by { rand }
    end
  end
end