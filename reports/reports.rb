#!/usr/bin/ruby
require 'grape'
require 'faraday'

module Reports
	class ReportCreator
		@@user_url = 'http://localhost:9191/user'
		@@items_url = 'http://localhost:9292/items'
		@@locations_url = 'http://localhost:9393/locations'
		
		def initialize
			@conn = setup_connection
		end

		def setup_connection
			Faraday.new do |faraday|
	    	faraday.request  :url_encoded             # form-encode POST params
	    	faraday.response :logger                  # log requests to STDOUT
	    	faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  		end
		end

		def has_valid_auth_token?(username, password)
			@conn.basic_auth username, password
			response = @conn.get @@user_url
			response.status == 200
		end
	end

	class API < Grape::API
		format :json
		
		report_creator = ReportCreator.new
		
		resource :reports
			http_basic do |username, password|
				valid_auth = report_creator.has_valid_auth_token? username, password
				error!('NO report', 403) if !valid_auth
				true
			end

			#params: by-location
		  get do
		    "report will follow!"
		  end
		end
end