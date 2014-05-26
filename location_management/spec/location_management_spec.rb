#!/usr/bin/ruby
Bundler.require

require 'rack/test'
require_relative '../lib/location_management'

describe LocationManagement::API do
  include Rack::Test::Methods

  def app
    LocationManagement::API
  end

  describe LocationManagement::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
  		end
  	end

		describe "unauthorized" do
  	end

  end
end