Bundler.require

require 'rack/test'
require 'webmock'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

include WebMock::API
WebMock.disable_net_connect!(allow_localhost: false)
