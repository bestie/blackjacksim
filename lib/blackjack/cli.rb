module Blackjack
  class CLI
    attr_reader :simulator
    DEFAULT_BANK_ROLL = 100
    
    def initialize(stdout, arguments)
      @stdout = stdout
      @strategy_file = arguments[0]
      
      unless @strategy_file and File.exists?(@strategy_file)
        display "No strategy file provided"
        return exit
      end
      
      @strategy = Strategy.new(@strategy_file)
      @player = Player.new(@strategy, DEFAULT_BANK_ROLL)
      @dealer = Dealer.new
      @shoe = Shoe.new(6)
      
      @simulator = Simulator.new(@player, @dealer, @shoe, @stdout)
      
    end
    
    def start
      display "Simulating 10 hands"
      display "Bank roll 100 chips"
      display ""
      
      win_count = 0
      loss_count = 0
      
      10.times do
        result = @simulator.play_hand
        if result.is_a?(PlayerWin)
          win_count += 1
          display "WIN"
        elsif result.is_a?(PlayerLoss)
          loss_count += 1
          display "LOSE"
        end
      end
      
      profit = @player.bank_roll - DEFAULT_BANK_ROLL
      
      display "Wins: #{win_count}"
      display "Losses: #{loss_count}"
      display "Profit: #{profit}"
    end
    
    private ##################################################################
    
    def display(string)
      @stdout.puts string
    end      
    
    def exit
    end
  end
end