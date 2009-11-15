require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Shoe do

    it "should have 52 cards per deck" do
      # repeat for 1 deck, two decks etc.
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
    
    it "should only deal between 50 and 80 percent of the cards and discard the rest" do
      number_of_decks = (1..6).to_a
      number_of_decks.each do |n|
        cards_in_shoe = 52 * n
        shoe = Shoe.new(n)
        cards_dealt = 0
        while card = shoe.deal do
          cards_dealt += 1
        end
        cards_dealt.should >= (cards_in_shoe * 0.5).ceil
        cards_dealt.should <= (cards_in_shoe * 0.8).ceil
      end
    end
    
  end
end