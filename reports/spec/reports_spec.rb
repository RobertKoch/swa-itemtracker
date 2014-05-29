#!/usr/bin/ruby
require 'spec_helper'
require_relative '../lib/reports'

final_result = @final_result

describe Reports::API do

  def app
    Reports::API
  end

  describe Reports::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'

        stub_request(:get, "http://paul:thepanther@localhost:9191/user").
          to_return(:status => 200, :body => "", :headers => {})
  		end

      describe "GET /reports/by-location" do
        it "returns status 200 and @final_report in json-format" do
          get "/reports/by-location"
          last_response.status.should == 200
          last_response.body.should == JSON.dump(final_result)
        end
      end
  	end

		describe "unauthorized" do
      before do
        authorize 'false', 'user'

        stub_request(:get, "http://false:user@localhost:9191/user").
          to_return(:status => 403, :body => "", :headers => {})
      end

      describe "GET /reports/by-location" do
        it "returns status 403 and error message" do
          get "/reports/by-location"
          last_response.status.should == 403
          last_response.body.should == '{"error":"NO report"}'
        end
      end
  	end

  end
end