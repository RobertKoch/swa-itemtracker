#!/usr/bin/ruby

module Reports
	class ReportCreator
		@@user_url = 'http://localhost:9191/user'
		@@items_url = 'http://localhost:9292/items'
		@@locations_url = 'http://localhost:9393/locations'
		
		def initialize
			@conn = setup_connection
			@auth_user = nil
			@auth_pwd = nil
		end

		def setup_connection
			Faraday.new do |faraday|
	    	faraday.request  :url_encoded             # form-encode POST params
	    	faraday.response :logger                  # log requests to STDOUT
	    	faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  		end
		end

		def check_and_set_auth(username, password)
			@conn.basic_auth username, password
			response = @conn.get @@user_url
			
			if response.status == 200
				@auth_user = username
				@auth_pwd = password
				true
			else
				false
			end
		end

		def build_report
			report = []
			entry = {}
			locations = self.get_locations
			items = self.get_items

			locations.each do |location|
				entry = location
				entry[:items] = items.select { |item| item['location'] == location['id'] }
				report << entry
			end
		end

		def get_locations
			@conn.basic_auth @auth_user, @auth_pwd
			reponse = @conn.get @@locations_url
			JSON.parse reponse.body
		end

		def get_items
			@conn.basic_auth @auth_user, @auth_pwd
			reponse = @conn.get @@items_url
			JSON.parse reponse.body
		end
	end

	class API < Grape::API
		format :json
		
		report_creator = ReportCreator.new
		
		resource :reports

			http_basic do |username, password|
				valid_auth = report_creator.check_and_set_auth username, password
				error!('NO report', 403) if !valid_auth
				true
			end
			
		  get 'by-location' do
		    report_creator.build_report
		  end
		end
end