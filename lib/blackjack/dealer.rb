module Blackjack
  class Dealer
    
    attr_reader :hand
    attr_reader :upcard
    
    def initialize
      initialize_hand
    end
    
    def hit(card)
      @hand << card
      @upcard << card if @hand.count == 1
    end
    
    def stand?
      @hand.value >= 17
    end
    
    def surrender_hand
      initialize_hand
    end
    
    private
    
    def initialize_hand
      @hand = Hand.new
      @upcard = Hand.new
    end
  end
end
