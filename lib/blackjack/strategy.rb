module Blackjack
  class Strategy
    def initialize(file)
      @decision_hash = {}
      if File.exists? file
        self.load_file(file)
      end
    end
    
    def decision(players_hand, dealers_upcard)
      return @decision_hash[players_hand.lookup][dealers_upcard.lookup]
    end
    
    def load_file(file)
      line_count = 0
      File.open(file, "r") do |infile|
        # skip first line
        line = infile.gets
        while line = infile.gets
          cols = line.split ","
          @decision_hash[cols[0]] = {}
          CARD_VALUES.each_with_index do |card_values, i|
            @decision_hash[cols[0]][card_values.to_s] = cols[i + 1].strip
          end          
        end
      end
    end
    
  end
end