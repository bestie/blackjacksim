module Blackjack
  
  class PlayerWin; end
  class PlayerLoss; end
  
  class PlayerBlackjack < PlayerWin; end
  class PlayerBankrupt < PlayerLoss; end
  class PlayerBust < PlayerLoss; end
  
  class Simulator
    def initialize(player, dealer, shoe, messenger)
      @player = player
      @messenger = messenger
      @shoe = shoe
      @dealer = dealer
    end
    
    def output(string)
      @messenger.puts(string)
    end

    def play_hand
      output "New Hand"
   
      @dealer.surrender_hand
      @player.surrender_hand
      
      if @player.bankrupt?
        output "Game Over: Player bankrupt"
        return PlayerBankrupt.new
      end

      @bet = @player.wager
      2.times do
        @player.hit @shoe.deal
        @dealer.hit @shoe.deal
      end
      
      if @player.hand.blackjack?
        @player.pay( 2.5 * @bet )
        return PlayerBlackjack.new
      end

      until @player.decision(@dealer.upcard) == 'S'
        @player.hit @shoe.deal
        return PlayerBust.new if @player.hand.bust?
      end
      
      until @dealer.stand? do
        @dealer.hit @shoe.deal
      end
      
      if @dealer.hand.bust? or @player.hand.value > @dealer.hand.value
        @player.pay( 2 * @bet )
        return PlayerWin.new
      else
        return PlayerLoss.new
      end
    end
    
  end
end