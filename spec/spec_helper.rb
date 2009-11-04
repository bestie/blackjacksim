Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  config.include(StandMatcher)
end

# add some extra methods to aid testing
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