Bundler.require

require 'rack/test'
require 'webmock'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

include WebMock::API
WebMock.disable_net_connect!(allow_localhost: false)

items = [
	{
		name: 'item1',
		location: 1,
		id: 1
	},
	{
		name: 'item2',
		location: 2,
		id: 2
	}
]

locations = [
	{
		name: 'location1',
		address: 'address1',
		id: 1
	},
	{
		name: 'location2',
		address: 'address2',
		id: 2
	}
]

@final_result = [
	locations[0].merge(items: [items[0]]),
	locations[1].merge(items: [items[1]])
]

stub_request(:get, "http://paul:thepanther@localhost:9292/items").
  to_return(:status => 200, :body => JSON.dump(items), :headers => {})

stub_request(:get, "http://paul:thepanther@localhost:9393/locations").
  to_return(:status => 200, :body => JSON.dump(locations), :headers => {})