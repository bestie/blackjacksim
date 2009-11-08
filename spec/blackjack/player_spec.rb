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
      player.hand.should have(0).cards
      
      player.hit 'K'
      player.hand.should have(1).cards
      
      player.hit 4
      player.hand.should have(2).cards
    end
    
    it "should make strategic decisions based on the dealers and its own hands" do
      player = Player.new(@strategy, 100)
      player.hit 'A'
      player.hit 7
      dealers_hand = Hand.new(9)
      player.decision(dealers_hand).should == 'H'
    end
    
    it "should admit bankrupcy when bankroll is depleted" do
      player = Player.new(@strategy, 0)
      player.should be_bankrupt
    end
    
    it "should wager and subtract from bank roll" do
      player = Player.new(@strategy, 100)
      lambda {
        player.wager
      }.should change(player, :bank_roll).by(-1)
      
      lambda {
        player.wager 2
      }.should change(player, :bank_roll).by(-2)
    end
    
    it "should return the size of the wager when wagering" do
      player = Player.new(@strategy, 100)
      player.wager(1).should == 1
      player.wager(2).should == 2
    end
    
    it "should not make a wager it cannot afford" do
      player = Player.new(@strategy, 1)
      lambda { player.wager(1).should == 1 }.should change(player, :bank_roll).by(-1)
      lambda { player.wager(1).should == false }.should_not change(player, :bank_roll)
    end
    
    it "should accept payment" do
      (1..10).to_a.each do |amount_won|
        player = Player.new(@strategy, 100)
        lambda {
          player.pay(amount_won)
        }.should change(player, :bank_roll).by(amount_won)
      end
    end
    
    it "should reset at the beginning of a new hand" do
      player = Player.new(@strategy, 100)
      player.hit 'A'
      player.hit 8
      player.hand.should have(2).cards
      player.surrender_hand
      player.hand.should have(0).cards
    end
  end
end
