Dir["#{File.dirname(__FILE__)}/../../lib/**/*.rb"].each {|f| require f}

require 'spec'
require 'spec/mocks'
require 'spec/stubs/cucumber'

# require File.join(File.dirname(__FILE__),'..', '..', 'spec','spec_helper')