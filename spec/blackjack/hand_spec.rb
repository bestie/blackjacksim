require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Hand do
    
    it "should add two number cards" do
      NUMBER_CARDS.each do |card1|
        NUMBER_CARDS.each do |card2|
          hand = Hand.new([card1,card2])
          hand.value.should == (card1 + card2)
        end
      end
    end
    
    it "should bust at over 21" do
      [ [10,10,2], [10,10,10] ].each do |cards|
        hand = Hand.new(cards)
        hand.should be_bust
      end
    end
    
    it "should not bust 21 and under" do
      [ [10,10], [10,10,1] ].each do |cards|
        hand = Hand.new(cards)
        hand.should_not be_bust
      end
    end
    
    it "should value picture cards as tens" do
      [ ['J'], ['Q'], ['K'] ].each do |cards|
        hand = Hand.new(cards)
        hand.value.should == 10
      end
    end
    
    it "should handle mixtures of picture and number cards" do
      Hand.new('J', 'Q').value.should == 20
      Hand.new('J', 5).value.should == 15
      Hand.new(2, 'K', 4).value.should == 16
    end
    
    it "should value aces as 11 until the hand is bust" do
      Hand.new('A').value.should == 11
      Hand.new('A', 5).value.should == 16
      Hand.new('A', 'J').value.should == 21
      Hand.new('A', 5, 6).value.should == 12
      Hand.new('A', 'A').value.should == 12
      Hand.new('A', 'A', 'A').value.should == 13
      Hand.new('A', 'A', 'A', 8).value.should == 21
      Hand.new('A', 'A', 'A', 9).value.should == 12
    end
    
    it "should know when it is soft" do
      Hand.new('A').should be_soft
      Hand.new('A', 2).should be_soft
      Hand.new('A', 8, 6).should be_soft
      Hand.new(2, 'A').should be_soft
      Hand.new(8, 'A', 2).should be_soft
               
      Hand.new(2).should_not be_soft
      Hand.new(2, 10).should_not be_soft
      Hand.new(2, 10, 10).should_not be_soft
      Hand.new(2, 'J').should_not be_soft
    end
    
    it "should know when it is a pair" do
      Hand.new(2,2)
      Hand.new(2,2).should be_a_pair
      Hand.new(10,10).should be_a_pair
      Hand.new('J','J').should be_a_pair
      Hand.new('J','Q').should be_a_pair
      Hand.new('A','A').should be_a_pair
      Hand.new(2,3).should_not be_a_pair
      Hand.new(8,'K').should_not be_a_pair
      Hand.new('A','K').should_not be_a_pair
      Hand.new(4,'A', 5).should_not be_a_pair
      Hand.new(2,2,3).should_not be_a_pair
    end
    
    it "should produce a hash lookup" do
      Hand.new(5,3).lookup.should == '8'
      Hand.new(10,3).lookup.should == '13'
      Hand.new(5,'J').lookup.should == '15'
      Hand.new(5,5).lookup.should == '5|5'
      Hand.new('A','A').lookup.should == 'A|A'
      Hand.new('A',5).lookup.should == 'A|5'
      Hand.new(6,'A').lookup.should == 'A|6'
      Hand.new('J','J').lookup.should == '10|10'
      Hand.new('Q','J').lookup.should == '10|10'
      Hand.new(7).lookup.should == '7'
      Hand.new('K').lookup.should == '10'
      Hand.new('A').lookup.should == 'A'
    end
    
    it "should accept new cards after initialization" do
      hand = Hand.new(3,7)
      hand.value.should == 10
      hand << 8
      hand.value.should == 18
    end
    
    it "should recognise a blackjack" do
      hand = Hand.new('K', 'A')
      hand.blackjack?.should be_true
    end
    
    it "should raise and exception if bad card is passed" do
      lambda {
        hand = Hand.new
        hand << nil
      }.should raise_error(InvalidCardException)
    end
      
  end
end