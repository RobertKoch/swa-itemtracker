#!/usr/bin/ruby
Bundler.require

require 'rack/test'
require_relative '../lib/item_tracking'

describe ItemTracking::API do
  include Rack::Test::Methods

  def app
    ItemTracking::API
  end

  describe ItemTracking::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
  		end
  	end

		describe "unauthorized" do
  	end

  end
end