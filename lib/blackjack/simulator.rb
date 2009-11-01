module Blackjack
  class Simulator
    def initialize(bankroll, strategy, messenger)
      @bankroll = bankroll
      @strategy = strategy
      @messenger = messenger
    end
    
    def start
      @messenger.puts "Result: 0.00"
    end
  end
end