#!/usr/bin/ruby
require 'spec_helper'
require_relative '../lib/location_management'

describe LocationManagement::API do

  def app
    LocationManagement::API
  end

  describe LocationManagement::API do
    
    describe "authorized" do
      before do
        authorize 'paul', 'thepanther'
 
        stub_request(:get, "http://paul:thepanther@localhost:9191/user").
          to_return(:status => 200, :body => "", :headers => {})
      end

      describe "GET /locations" do
        it "return status 200" do
          get "/locations"
          last_response.status.should == 200
          last_response.body.should == '[]'
        end
      end

      describe "POST /locations" do
        it "return status 201 with correct params" do
          post "/location", {name: 'location', address: 'address'}
          last_response.status.should == 201
          JSON.parse(last_response.body).should == {'name' => 'location', 'address' => 'address', 'id' => 1}
        end

        it "return status 400 and error message without any params" do
          post "/location"
          last_response.status.should == 400
          last_response.body.should == '{"error":"name is missing, address is missing"}'
        end

        it "return status 400 and error message without name param" do
          post "/location", {address: 'address'}
          last_response.status.should == 400
          last_response.body.should == '{"error":"name is missing"}'
        end

        it "return status 400 and error message without address param" do
          post "/location", {name: 'location'}
          last_response.status.should == 400
          last_response.body.should == '{"error":"address is missing"}'        
        end

      end

      describe "DELETE /locations/:id" do
      end
    end

    describe "unauthorized" do
      before do 
        authorize 'false', 'user'

        stub_request(:get, "http://false:user@localhost:9191/user").
          to_return(:status => 403, :body => "", :headers => {})
      end

      describe "GET /locations" do
        it "returns status 403" do
          get "/locations"
          last_response.status.should == 403
        end
      end

      describe "POST /location" do
        it "returns status 403" do
          post "/location"
          last_response.status.should == 403
        end
      end

      describe "DELETE /location/:id" do
        it "returns status 403" do
          delete "/location"
          last_response.status.should == 403
        end
      end
    end

    describe "not authorized" do
      before do
        stub_request(:get, "http://localhost:9191/user").
          to_return(:status => 401, :body => "", :headers => {})
      end

      describe "GET /locations" do
        it "returns status 401" do
          get "/locations"
          last_response.status.should == 401
        end
      end

      describe "POST /location" do
        it "returns status 401" do
          post "/location"
          last_response.status.should == 401
        end
      end

      describe "DELETE /location/:id" do
        it "returns status 401" do
          delete "/location"
          last_response.status.should == 401
        end
      end
    end

  end
end