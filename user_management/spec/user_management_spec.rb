#!/usr/bin/ruby
Bundler.require

require 'rack/test'
require_relative '../lib/user_management'

describe UserManagement::API do
  include Rack::Test::Methods

  def app
    UserManagement::API
  end

  describe UserManagement::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
  		end
  		describe "GET /user" do
  			it "returns status 200" do
  				get "/user"
  				last_response.status.should == 200
  			end
  		end
  	end

		describe "unauthorized" do
  		describe "GET /user without credentials" do
  			it "returns status 401" do
  				get "/user"
  				last_response.status.should == 401
  			end
  		end
  		describe "GET /user with false credentials" do
  			it "returns status 403" do
  				authorize 'false', 'user'
  				get "/user"
  				last_response.status.should == 403
  			end
  		end
  	end

  end
end