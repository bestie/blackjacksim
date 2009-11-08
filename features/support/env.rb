Dir["#{File.dirname(__FILE__)}/../../lib/**/*.rb"].each {|f| require f}

require 'spec'
require 'spec/mocks'
require 'spec/stubs/cucumber'