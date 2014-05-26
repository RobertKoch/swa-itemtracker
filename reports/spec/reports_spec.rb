#!/usr/bin/ruby
Bundler.require

require 'rack/test'
require_relative '../lib/reports'

describe Reports::API do
  include Rack::Test::Methods

  def app
    Reports::API
  end

  describe Reports::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
  		end
  	end

		describe "unauthorized" do
  	end

  end
end