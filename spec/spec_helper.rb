ENV['RACK_ENV'] ||= 'test'
require 'rack_slashless'
require 'rack/test'

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
end