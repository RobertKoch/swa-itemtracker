#!/usr/bin/ruby
require 'spec_helper'
require_relative '../lib/item_tracking'

describe ItemTracking::API do

  def app
    ItemTracking::API
  end

  describe ItemTracking::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
 
        stub_request(:get, "http://paul:thepanther@localhost:9191/user").
          to_return(:status => 200, :body => "", :headers => {})
  		end

      describe "GET /items" do
        it "return status 200" do
          get "/items"
          last_response.status.should == 200
          last_response.body.should == '[]'
        end
      end

      describe "POST /items" do
        it "return status 201 with correct params" do
          post "/items", {name: 'item', location: 123}
          last_response.status.should == 201
          JSON.parse(last_response.body).should == {'name' => 'item', 'location' => 123, 'id' => 1}
        end

        it "return status 400 and error message without any params" do
          post "/items"
          last_response.status.should == 400
          last_response.body.should == '{"error":"name is missing, location is missing"}'
        end

        it "return status 400 and error message without name param" do
          post "/items", {location: 123}
          last_response.status.should == 400
          last_response.body.should == '{"error":"name is missing"}'
        end

        it "return status 400 and error message without location param" do
          post "/items", {name: 'item'}
          last_response.status.should == 400
          last_response.body.should == '{"error":"location is missing"}'        
        end

        it "return status 400 and error message with incorrect location param" do
          post "/items", {name: 'item', location: "a string"}
          last_response.status.should == 400
          last_response.body.should == '{"error":"location is invalid"}'        
        end
      end

      describe "DELETE /item/:id" do
      end
  	end

		describe "unauthorized" do
      before do 
        authorize 'false', 'user'

        stub_request(:get, "http://false:user@localhost:9191/user").
          to_return(:status => 403, :body => "", :headers => {})
      end

      describe "GET /items" do
        it "returns status 403" do
          get "/items"
          last_response.status.should == 403
        end
      end

      describe "POST /items" do
        it "returns status 403" do
          post "/items"
          last_response.status.should == 403
        end
      end

      describe "DELETE /item/:id" do
        it "returns status 403" do
          delete "/item"
          last_response.status.should == 403
        end
      end
  	end

    describe "not authorized" do
      before do
        stub_request(:get, "http://localhost:9191/user").
          to_return(:status => 401, :body => "", :headers => {})
      end

      describe "GET /items" do
        it "returns status 401" do
          get "/items"
          last_response.status.should == 401
        end
      end

      describe "POST /items" do
        it "returns status 401" do
          post "/items"
          last_response.status.should == 401
        end
      end

      describe "DELETE /item/:id" do
        it "returns status 401" do
          delete "/item"
          last_response.status.should == 401
        end
      end
    end

  end
end