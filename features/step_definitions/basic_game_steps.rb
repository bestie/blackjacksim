def output
  @stdout ||= StringIO.new
end

def output_should_contain(string)
  output_segments.should include(string)
end

def output_should_not_contain(string)
  output_segments.should_not include(string)
end
def output_segments
  output.string.split("\n")
end

Then /^I should see "([^\"]*)"$/ do |string|
  output_should_contain(string)
end

Then /^I should not see "([^\"]*)"$/ do |string|
  output_should_not_contain(string)
end

Then /^I should only see "([^\"]*)"$/ do |string|
  output_segments[0].should == string
end

Then /^I see the log file$/ do
  puts output
end

Given /^I have a strategy$/ do
  @strategy_file = File.join(ROOT, 'spec', 'strategies', 'stand_on_16.csv')
  File.exists?(@strategy_file).should be_true
end

Given /^the player wins all hands$/ do
  # to acheive this the plater always stands on 16
  @strategy_file = File.join(ROOT, 'spec', 'strategies', 'stand_on_16.csv')
  File.exists?(@strategy_file).should be_true
  
  # and the dealer always busts
  rigged_cards = Blackjack::Shoe.arrange_cards( :player => [ 10, 10], :dealer => [ 10, 5, 10] )
  @cli.simulator.shoe.should_deal( rigged_cards * 100 )
end

Given /^the player loses every hand$/ do
  @strategy_file = File.join(ROOT, 'spec', 'strategies', 'stand_on_16.csv')
  File.exists?(@strategy_file).should be_true
  
  # player always gets 17 and stands, dealer always gets 20
  rigged_cards = Blackjack::Shoe.arrange_cards( :player => [ 10, 7], :dealer => [ 10, 5, 5] )
  @cli.simulator.shoe.should_deal( rigged_cards * 100 )
end

Given /^the player and dealer win equal hands$/ do
  @strategy_file = File.join(ROOT, 'spec', 'strategies', 'stand_on_16.csv')
  File.exists?(@strategy_file).should be_true
  
  dealer_bust_cards = Blackjack::Shoe.arrange_cards( :player => [ 10, 10], :dealer => [ 10, 5, 10] )
  dealer_win_cards = Blackjack::Shoe.arrange_cards( :player => [ 10, 7], :dealer => [ 10, 5, 5] )
  combined_cards = [ dealer_win_cards, dealer_bust_cards ].flatten * 5
  @cli.simulator.shoe.should_deal( combined_cards )
end


When /^I initialise the simulator with no options$/ do
  @cli = Blackjack::CLI.new(output, [])
end

When /^I initialise the simulator with a valid file$/ do
  args = [@strategy_file]
  @cli = Blackjack::CLI.new(output, args)
end

When /^the simulator starts$/ do
  @cli.start
end

Then /^I should see ([0-9]+) game results$/ do |number|
  counter = 0
  output_segments.each do |line|
    counter += 1 if line =~ /WIN|LOSE$/
  end
  counter.should == number.to_i
end

Then /^I should see a results summary$/ do
  things_to_see = []
  things_to_see << /Wins: [0-9]+/
  things_to_see << /Losses: [0-9]+/
  things_to_see << /Profit: \-?[0-9]+/
  
  things_found = 0
  
  things_to_see.each do |pattern|
    output_segments.each do |line|
      things_found += 1 if line =~ pattern
    end
  end
  
  things_found.should == things_to_see.length
end

Then /^I should see ([0-9]+) "([^\"]*)" results$/ do |number, wins_losses|
  counter = 0
  pattern = Regexp.new(wins_losses)
  output_segments.each do |line|
    counter += 1 if line =~ pattern
  end
  counter.should == number.to_i
end