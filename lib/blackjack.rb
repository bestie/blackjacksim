Dir["#{File.dirname(__FILE__)}/backjack/**/*.rb"].each {|f| require f}

module Blackjack
  CARDS = [ 'A',2,3,4,5,6,7,8,9,'J','Q','K' ]
  CARD_VALUES = [ 2,3,4,5,6,7,8,9,10,'A' ]
  NUMBER_CARDS = [ 2,3,4,5,6,7,8,9,10 ]
  PICTURE_CARDS = [ 'J', 'Q', 'K']
end