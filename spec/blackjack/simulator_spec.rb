require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Simulator do
    
    def output_should_include(string)
      @messenger.string.split("\n").should include(string)
    end
    
    before(:each) do
      strategy = Strategy.new(Blackjack.strategy_file("hit_straight_under_17"))
      bankroll = 100
      @decks_in_game = 6
      @cards_in_game = 6 * 52
      @player = Player.new(strategy, bankroll)
      
      @dealer = Dealer.new
      @messenger = StringIO.new
      @shoe = Shoe.new(@decks_in_game)
      
      @sim = Simulator.new(@player, @dealer, @shoe, @messenger)
      
      @player.bank_roll.should == 100
      @shoe.should have(@cards_in_game).cards
      @player.hand.should have(0).cards
      @dealer.hand.should have(0).cards
    end
    
    it "should refuse to play if the player has no money" do
       @player.should_receive(:bankrupt?).once.and_return(true)
       @shoe.should_not_receive(:deal)
       
       @sim.play_hand
       output_should_include "Game Over: Player bankrupt"
     end
     
     it "should deal no more cards if the player decides to stand" do
       @player.should_decide('S')
       @shoe.should_deal_to( :player => ['Q', 3], :dealer => [4,7,8])
     
       @sim.play_hand
     
       @player.bank_roll.should == 99
       @player.hand.should have(2).cards
     end
    
    it "should hit player once" do
      @shoe.should_deal_to( :player => [5,6,8] )
      @player.should_decide('H', 'S')
      
      @sim.play_hand
      @player.hand
      @player.hand.should have(3).cards
    end
    
    it "should hit player twice" do
      @shoe.should_deal_to( :player => [5,6,4,3] )
      @player.should_decide('H', 'H', 'S')
      
      @sim.play_hand
      @player.hand.should have(4).cards
    end
    
    it "should stop hitting the player when bust" do
      @player.should_receive(:decision).at_least(:once).and_return('H')
      @shoe.should_bust_player_in(2)
      @sim.play_hand
    end
    
    it "should pay the player 3 to 2 if she gets blackjack" do
      lambda {
        @player.should_not_receive(:decision)
        @shoe.should_deal_to( :player => ['A', 'K'])
        @sim.play_hand
      }.should change(@player, :bank_roll).by(1.5)
    end
    
    it "should not deal to dealer if dealer already has 17" do
      @shoe.should_deal_to( :player => [10,10], :dealer => [10,7] )
      @player.should_receive(:decision).once.and_return('S')
      @sim.play_hand
    end
    
    it "should test its own test helper" do
      player_cards = [10,7,3]
      dealer_cards = [2,5,2,6,3]
      @shoe.should_deal_to( :player => player_cards, :dealer => dealer_cards )
      @player.should_decide('H', 'S')
      @sim.play_hand
      
      @player.hand.cards.should == player_cards
      @dealer.hand.cards.should == dealer_cards
      
    end
    
    it "should give dealer cards until she reaches 17" do
      @shoe.should_deal_to( :player => [10,7], :dealer => [2,5,2,6,3] )
      @player.should_decide('S')
      @sim.play_hand
    end
    
    it "should pay the player should he have a better hand" do
      @shoe.should_deal_to( :player => ['A',9], :dealer => [2,5,2,6,3] )
      @player.should_decide('S')
      lambda {
        @sim.play_hand
      }.should change(@player, :bank_roll).by(1)
    end
    
    it "should pay the player if the dealer busts" do
      @shoe.should_deal_to( :player => [2,3], :dealer => [2,5,2,6,8] )
      @player.should_decide('S')
      lambda {
        @sim.play_hand
      }.should change(@player, :bank_roll).by(1)
    end
    
    it "should take the players money and end the game if the player loses" do
      @shoe.should_deal_to( :player => ['Q', 4, 3], :dealer => [2,5,2,6,5] )
      @player.should_decide('H', 'S')

      lambda {
        @sim.play_hand
      }.should change(@player, :bank_roll).by(-1)
    end
    
    it "should play many hands consecutively" do
      10.times do      
        # first a losing hand?
        @shoe.should_deal_to( :player => ['K', 2, 4], :dealer => ['J', 2, 6])
        @player.should_decide('H', 'S')
        lambda { # player should lose
          @sim.play_hand
        }.should change(@player, :bank_roll).by(-1)
        @player.hand.should have(3).cards
        @dealer.hand.should have(3).cards
      
        # then a winning hand
        @shoe.should_deal_to( :player => ['K', 5, 6], :dealer => ['J', 2, 6])
        @player.should_decide('H', 'S')
        lambda { # player should lose
          @sim.play_hand
        }.should change(@player, :bank_roll).by(1)
        @player.hand.should have(3).cards
        @dealer.hand.should have(3).cards
      end
      
      @player.bank_roll.should == 100
    end
    
    it "should return a value corresponding to a loss, no busts" do
      @shoe.should_deal_to( :player => ['K', 2, 4], :dealer => ['J', 2, 6])
      @player.should_decide('H', 'S')
      @sim.play_hand.should be_a(PlayerLoss)
      
    end
    
    it "should return a value corresponding to a win, no busts" do
      @shoe.should_deal_to( :player => ['K', 5, 6], :dealer => ['J', 2, 6])
      @player.should_decide('H', 'S')
      @sim.play_hand.should be_a(PlayerWin)
    end
    
    it "should return an appropriate value for a player getting a blackjack" do
      @shoe.should_deal_to( :player => ['K', 'A'], :dealer => [8, 5])
      @player.should_not_receive(:decision)
      result = @sim.play_hand
      result.should be_a(PlayerWin)
      result.should be_a(PlayerBlackjack)
    end
    
    it "should return an appropriate value for player bankrupt" do
      @player = Player.new(@strategy, 0)
      @sim = Simulator.new(@player, @dealer, @shoe, @messenger)
      result = @sim.play_hand
      result.should be_a(PlayerLoss)
      result.should be_a(PlayerBankrupt)
    end
    
    it "should return an appropriate value for player going bust" do
      @shoe.should_deal_to( :player => [10, 3, 2, 10], :dealer => [8, 5])
      @player.should_decide('H', 'H')
      result = @sim.play_hand
      result.should be_a(PlayerBust)
      result.should be_a(PlayerLoss)
    end
  end
end