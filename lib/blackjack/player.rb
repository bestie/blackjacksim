module Blackjack
  class Player 
    attr_accessor :hand
    attr_reader :bank_roll
    
    def initialize(strategy, bank_roll = 100, hand = nil)
      @strategy = strategy
      @hand = hand || Hand.new
      @bank_roll = bank_roll
    end
    
    def decision(dealers_hand)
      return @strategy.decision(@hand, dealers_hand)
    end
    
  end
end