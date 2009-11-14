ROOT = File.join(File.dirname(__FILE__), '..', '..')
# Dir["#{ROOT}/lib/**/*.rb"].each {|f| require f}


require 'spec'
require 'spec/mocks'
require 'spec/stubs/cucumber'
require File.join(ROOT, 'spec', 'spec_helper')
