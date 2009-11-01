$LOAD_PATH << File.join(File.dirname(__FILE__),"blackjack")
$LOAD_PATH << File.join(File.dirname(__FILE__),"support")
Dir["#{File.dirname(__FILE__)}/blackjack/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

module Blackjack
  CARDS = [ 'A',2,3,4,5,6,7,8,9,10,'J','Q','K' ]
  CARD_VALUES = [ 2,3,4,5,6,7,8,9,10,'A' ]
  NUMBER_CARDS = [ 2,3,4,5,6,7,8,9,10 ]
  PICTURE_CARDS = [ 'J', 'Q', 'K']
end