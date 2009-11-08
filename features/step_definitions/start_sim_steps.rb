
def messenger
  @messenger ||= StringIO.new
end

def dealer
  @dealer ||= Blackjack::Dealer.new
end

Then /^I should see "(.+)"$/ do |message|
  @messenger.string.split("\n").should include(message)
end

def strategy_file(filename)
  filename += '.csv' unless filename[-4..-1] == '.csv'
  File.join(File.dirname(__FILE__),'..','..','spec',"strategies",filename)
end

Given /^I have a strategy$/ do
  @strategy = Blackjack::Strategy.new(strategy_file("always_stand"))
end

Given /^a player$/ do
  @player = Blackjack::Player.new(@strategy, @bank_roll)
end

Given /^a bankroll of ([0-9]+)$/ do |bankroll_amount|
  @bank_roll = bankroll_amount.to_i
end

Given /^the shoe has ([0-9]+) decks?$/ do |number_of_decks|
  @shoe = Blackjack::Shoe.new(number_of_decks.to_i)
end

When /^I start the a new hand$/ do
  @simulator = Blackjack::Simulator.new(@player, dealer, @shoe, messenger)
  @simulator.begin_hand
  
  
end

Given /^the player is bankrupt$/ do
  @player.should_receive(:bankrupt?).once.and_return(true)
end

Then /^([0-9]+) cards should be dealt$/ do |number|
  @shoe.should_receive(:deal).exactly(number).times
end

Then /^the player should have placed a bet$/ do
  @player.bank_roll
  @bank_roll
  @player.bank_roll < @bank_roll
end

Then /^the player should have ([0-9]+) cards$/ do |number|
  @player.hand.count.should == number.to_i
end

Then /^the dealer should have ([0-9]+) cards$/ do |number|
  dealer.hand.count.should == number.to_i
end

Given /^the player will hit ([0-9]+) times? and stand$/ do |number|
  hits = 0
  @player.should_receive(:decision).and_return do
    # hits += 1
    # return 'H' if hits <= number 
  end

  @simulator.continue
end

When /^the game continues$/ do
  
end

