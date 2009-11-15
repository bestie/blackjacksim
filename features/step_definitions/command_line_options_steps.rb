When /^I initialise the simulator with a valid file and "([^\"]*)"$/ do |options|
  args = [ @strategy_file, options.split(' ') ].flatten
  @cli = Blackjack::CLI.new(output, args)
end

When /^I initialise the simulator with options "([^\"]*)"$/ do |options|
  args = options.split " "
  @cli = Blackjack::CLI.new(output, args)
end

Then /^I should see usage instructions$/ do
  Blackjack::CLI::USAGE.split("\n").each do |line|
    Then "I should see \"#{line}\""
  end
end

Then /^I should the help message$/ do
  Then "I should see \"#{Blackjack::CLI::HELP_MESSAGE}\""
end

