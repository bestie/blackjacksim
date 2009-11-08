module Blackjack
  class Hand

    attr_reader :cards

    def initialize(*args)
      @cards = []
      args.flatten.each do |card|
        @cards << card if CARDS.include?(card)
      end
    end
    
    def value
      value = 0
      aces = 0
      
      @cards.each do |card|
        if PICTURE_CARDS.include?(card)
          value += 10
        elsif card == 'A'
          aces += 1
          value += 1 # add the minimum
        else
          value += card
        end
      end
      
      # add another 10 for each ace unless it will bust
      aces.times do
        value += 10 if (value + 10) < 22
      end
        
      return value
    end
    
    def <<(card)
      raise InvalidCardException unless CARDS.include?(card)
      @cards << card
    end
    
    def count
      @cards.length
    end
    
    def bust?
      value > 21
    end
    
    def soft?
      @cards.include? 'A'
    end
    
    def pair?
      if @cards.length == 2
        return true if @cards[0] == @cards[1]
        return true if PICTURE_CARDS.include?(@cards[0]) and PICTURE_CARDS.include?(@cards[1])
      end
    end
    
    def lookup
      if @cards.length == 1
        return @cards[0] if @cards[0] == 'A'
        return value.to_s
      elsif pair?
        return '10|10' if PICTURE_CARDS.include?(@cards[0])
        return "#{@cards[0]}|#{@cards[1]}"
      elsif @cards.length == 2 and soft?
        return "A|" + (value - 11).to_s
      else
        return value.to_s
      end
    end
    
    def blackjack?
      value == 21 and count == 2
    end
  end
end