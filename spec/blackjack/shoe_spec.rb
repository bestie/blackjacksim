require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Shoe do

    it "should have 52 cards per deck" do
      6.times do |decks|
        shoe = Shoe.new(decks)
        shoe.count.should == 52 * decks
      end
    end
    
    it "should have 1 less card after a card is dealt" do
      shoe = Shoe.new(1)
      shoe.count.should == 52
      shoe.deal
      shoe.count.should == 51
      shoe.deal
      shoe.count.should == 50
    end
    
  end
end