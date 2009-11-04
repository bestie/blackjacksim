require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Player do
    
    before(:each) do
      @strategy = Strategy.new(Blackjack.strategy_file("always_hit"))
      @hand = Hand.new
    end
    
    it "should initialize with a strategy, bank roll and a hand" do
      player = Player.new(@strategy, 200)
      player.hit 7
      player.hit 5
      player.hand.should be_an_instance_of(Hand)
      player.hand.value.should == 12
      player.bank_roll.should == 200
      
      player = Player.new(@strategy, 2000)
      player.hit 3
      player.hit 8
      player.hand.value.should == 11
      player.bank_roll.should == 2000
    end
    
    it "should accept new cards into its hand" do
      player = Player.new(@strategy, @hand)
      player.hand.count.should == 0
      
      player.hit 'K'
      player.hand.count.should == 1
      
      player.hit 4
      player.hand.count.should == 2
    end
    
    it "should make strategic decisions based on the dealers and its own hands" do
      player = Player.new(@strategy, 100)
      player.hit 'A'
      player.hit 7
      dealers_hand = Hand.new(9)
      player.decision(dealers_hand).should == 'H'
    end
  end
end
