module Blackjack
  class Player
    attr_reader :hand, :bank_roll
    
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
    
    def bankrupt?
      not @bank_roll > 0
    end
    
    def wager(size = 1)
      if (@bank_roll - size) >= 0
        @bank_roll -= size
        return size
      else
        return false
      end
    end
  
    def pay(amount)
      @bank_roll += amount
    end
  end
end