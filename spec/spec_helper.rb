ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require './app'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

def response
  last_response
end
