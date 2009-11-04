require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Dealer do
    before(:each) do
      @dealer = Dealer.new
    end
    
    it "should accept cards into its hand" do
      @dealer.hit 7
      @dealer.hand.value.should == 7
      @dealer.hit 9
      @dealer.hand.value.should == 16
    end
    
    it "should not stand under 17" do
      @dealer.hit 10
      @dealer.hit 6
      @dealer.should_not stand
    end
    
    it "should stand on 17" do
      @dealer.hit 9
      @dealer.hit 8
      @dealer.should stand
    end
    
    it "should stand above 17" do
      @dealer.hit 10
      @dealer.hit 8
      @dealer.should stand
    end
    
    it "should hold its first card as its upcard" do
      @dealer.hit 4
      @dealer.upcard.value.should == 4
      @dealer.hit 5
      @dealer.upcard.value.should == 4
    end

  end
end
