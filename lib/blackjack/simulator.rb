module Blackjack
  
  class PlayerWin; end
  class PlayerLoss; end
  
  class PlayerBlackjack < PlayerWin; end
  class PlayerBankrupt < PlayerLoss; end
  class PlayerBust < PlayerLoss; end
  
  class Simulator
    
    attr_reader :shoe
    
    def initialize(player, dealer, shoe, messenger)
      @player = player
      @messenger = messenger
      @shoe = shoe
      @dealer = dealer
    end
    
    def play_hand      
      @dealer.surrender_hand
      @player.surrender_hand
      
      if @player.bankrupt?
        return PlayerBankrupt.new
      end
      
      @bet = @player.wager
      2.times do
        @player.hit get_card
        @dealer.hit get_card
      end
      
      if @player.hand.blackjack?
        @player.pay( 2.5 * @bet )
        return PlayerBlackjack.new
      end
      
      until @player.decision(@dealer.upcard) == 'S'
        @player.hit get_card
        return PlayerBust.new if @player.hand.bust?
      end
      
      until @dealer.stand? do
        @dealer.hit get_card
      end
      
      if @dealer.hand.bust? or @player.hand.value > @dealer.hand.value
        @player.pay( 2 * @bet )
        return PlayerWin.new
      else
        return PlayerLoss.new
      end
    end
    
    private ##################################################################
    
    def get_card
      card = @shoe.deal
      if card.nil?
        @shoe.reset_cards
        card = @shoe.deal
      end
      
      return card
    end
    
    def output(string)
      @messenger.puts(string)
    end
  end
end