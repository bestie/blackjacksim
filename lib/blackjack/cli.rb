require 'optparse'

module Blackjack
  class CLI
    attr_reader :simulator
    DEFAULT_BANK_ROLL = 100
    DEFAULT_HANDS = 10
    
    def initialize(stdout, arguments)
      @stdout = stdout
      return exit unless load_args(arguments)
      
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
      return exit unless @simulator
      display "Simulating #{@hands} hands"
      display "Bank roll 100 chips"
      display ""
      
      win_count = 0
      loss_count = 0
      
      @hands.times do
        result = @simulator.play_hand
        if result.is_a?(PlayerWin)
          win_count += 1
          display "WIN"
        elsif result.is_a?(PlayerLoss)
          loss_count += 1
          display "LOSE"
          if result.is_a?(PlayerBankrupt)
            display "GAME OVER Player bankrupt"
            return exit
          end
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
    
    def load_args(arguments)
      if arguments.length == 0
        display HELP_MESSAGE
        return exit
      end
      
      @strategy_file = arguments.shift unless arguments[0][0].chr == '-'
      @hands = DEFAULT_HANDS

      opts = OptionParser.new do |opts|
        opts.banner = WELCOME
        opts.on( '-n [NUMBER]', '--number-of-hands [NUMBER]', Float, 'Number of hands to be played' ) do |n|
          @hands = n.to_i
        end
        opts.on( '-h', '--help', 'Display this screen' ) do
          display USAGE
          display opts
          # return exit
        end
      end
      
      opts.parse!(arguments)
    end
    
    WELCOME = %Q{Blackjacksim v0.1\nauthor: Stephen Best\nFork me: http://github.com/bestie/blackjacksim}
    USAGE = %Q{Usage: blackjacksim <strategy csv file> [options]}
    HELP_MESSAGE = %Q{blackjacksim --help for more info} 
  end
end