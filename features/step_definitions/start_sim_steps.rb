
def messenger
  @messenger ||= StringIO.new
end

Given /^I have a strategy$/ do
  @strategy = Blackjack::Strategy.new(strategy_file("always_stand"))
end

When /^I start the simulator$/ do
  bankroll = 100.00
  @sim = Blackjack::Simulator.new(bankroll, @strategy, messenger)
  @sim.start
end

Then /^I should see the results$/ do
  messenger.string.should match(/Result: ([0-9]+\.[0-9]{2})/)
end