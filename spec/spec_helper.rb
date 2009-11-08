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
  
  class Player
    def should_decide(*decisions)
      decisions.reverse!
      self.should_receive(:decision).exactly(decisions.length).times.and_return{
        decisions.pop
      }
    end
  end
  
  class Shoe
    def should_deal(*cards)
      # p cards
      cards.flatten!.reverse!
      self.should_receive(:deal).at_least(cards.length).times.and_return { cards.pop }
    end
    
    def should_bust_player_in(hits)
      if hits == 1
        cards = [ 8, 8, 4, 4]
        cards.push(10) # giving 22 on player's first hit
      else
        cards = [ 2, 2, 3, 3] # deal a minimal hand for sufficient headroom
        allowance = 21 - 5
        average_per_hit = (allowance / hits.to_f).ceil
        (hits - 1).times do
          cards.push(average_per_hit)
        end
        cards.push(average_per_hit + 1)
      end
      should_deal cards
    end
    
    def should_deal_to(hash)
      player_cards = hash[:player].flatten.reverse
      dealer_cards = [10,7]
      dealer_cards = hash[:dealer].flatten.reverse if hash[:dealer].is_a?(Array)
      all_cards = []
      
      # alternate cards first two
      2.times do
        all_cards << player_cards.pop if player_cards.length > 0
        all_cards << dealer_cards.pop if dealer_cards.length > 0
      end
      
      # players cards next
      player_cards.length.times { all_cards << player_cards.pop }
      # then dealers cards
      dealer_cards.length.times { all_cards << dealer_cards.pop }
      
      should_deal all_cards
    end
  end
  
  def self.strategy_file(filename)
    filename += '.csv' unless filename[-4..-1] == '.csv'
    File.join(File.dirname(__FILE__),"strategies",filename)
  end
  
end