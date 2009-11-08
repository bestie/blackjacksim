module Blackjack
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
      if @player.bankrupt?
        output "Game Over: Player bankrupt"
        return false
      end

      @bet = @player.wager
      2.times do
        @player.hit @shoe.deal
        @dealer.hit @shoe.deal
      end
      
      if @player.hand.blackjack?
        @player.pay( 2.5 * @bet )
        return true
      end

      until @player.decision(@dealer.upcard) == 'S'
        @player.hit @shoe.deal
        return false if @player.hand.bust?
      end
      
      until @dealer.stand? do
        @dealer.hit @shoe.deal
      end
      
      if @dealer.hand.bust? or @player.hand.value > @dealer.hand.value
        @player.pay( 2 * @bet )
        return true
      end
    end
    
  end
end