require File.join(File.dirname(__FILE__), "..","spec_helper")

module Blackjack
  describe Deck do
    before(:each) do
      @deck = Deck.new
    end
    
    context "when initializing" do
      it "should have 52 cards" do
        @deck.cards.length.should == 52
      end
    
      it "should contain 4 complete suits" do
        CARDS.each do |test_card|
          card_count = 0
          @deck.cards.each do |deck_card|
            card_count += 1 if deck_card == test_card
          end
          card_count.should == 4
        end
      end
    
      it "should be shuffled" do
        shuffled = false
        CARDS.each_with_index do |test_card,i|
          shuffled = true if test_card != @deck.cards[i]
        end
        shuffled.should be_true
      end
    end
  end
end