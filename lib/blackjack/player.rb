module Blackjack
  class Player
    attr_accessor :hand
    attr_reader :bank_roll
    
    def initialize(strategy, bank_roll = 100)
      @strategy = strategy
      @bank_roll = bank_roll
      @hand = Hand.new
    end
    
    def hit(card)
      @hand << card
    end
    
    def decision(dealers_hand)
      return @strategy.decision(@hand, dealers_hand)
    end
    
  end
end