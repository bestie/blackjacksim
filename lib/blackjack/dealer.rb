module Blackjack
  class Dealer
    
    attr_accessor :hand
    attr_accessor :upcard
    
    def initialize
      @hand = Hand.new
      @upcard = Hand.new
    end
    
    def hit(card)
      @hand << card
      @upcard << card if @hand.count == 1
    end
    
    def stand?
      @hand.value >= 17
    end
  end
end
