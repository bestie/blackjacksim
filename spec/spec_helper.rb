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
  
  def self.strategy_file(filename)
    filename += '.csv' unless filename[-4..-1] == '.csv'
    File.join(File.dirname(__FILE__),"strategies",filename)
  end
  
end