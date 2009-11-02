require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Strategy do
    it "should always stand given an always stand strategy" do
      strategy = Strategy.new(strategy_file("always_stand"))
      players_hand = Hand.test_hand
      dealers_upcard = Hand.test_upcard
      
      strategy.decision(players_hand, dealers_upcard).should == 'S'
    end
    
    it "should always hit on with an always hit strategy" do
      strategy = Strategy.new(strategy_file("always_hit"))
      players_hand = Hand.test_hand
      dealers_upcard = Hand.test_upcard
      
      strategy.decision(players_hand, dealers_upcard).should == 'H'
    end
    
    it "should make correct decision for hit under 17 strategy" do
      strategy = Strategy.new(Blackjack.strategy_file("hit_straight_under_17"))
      CARDS.each do |upcard|
        players_hand = Hand.new(['J',6])
        dealers_upcard = Hand.new([upcard])
        strategy.decision(players_hand, dealers_upcard).should == 'H'
      end
    end

    it "should make correct decision for hit under 17 strategy" do
      strategy = Strategy.new(Blackjack.strategy_file("hit_straight_under_17"))
      CARDS.each do |upcard|
        players_hand = Hand.new([10,7])
        dealers_upcard = Hand.new([upcard])
        strategy.decision(players_hand, dealers_upcard).should == 'S'
      end
    end
  end
end