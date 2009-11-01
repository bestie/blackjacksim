Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}

module Blackjack  
  class Hand

    def self.test_hand
      Hand.new([CARDS.rand, CARDS.rand])
    end
    
    def self.test_upcard
      Hand.new([CARDS.rand])
    end
  end
  
end