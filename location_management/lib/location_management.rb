#!/usr/bin/ruby

module LocationManagement
	class LocationManager
		def initialize
			@locations = []
			@next_id = 1
		end
		
		def all
			@locations
		end

		def find(loc_id)
			@locations.select {|loc| loc[:id] == loc_id}
		end

		def create(name, address)
			location = {
				:name => name,
				:address => address,
				:id =>  @next_id
			}

			@locations << location
			@next_id += 1

			#return last inserted location
			location
		end

		def delete(loc_id)
			if location = self.find(loc_id)[0]
				@locations.delete location
				true
			else
				false
			end
		end
	end

	class API < Grape::API
		format :json
		
		location_manager = LocationManager.new
		
		desc "Show all locations"
	  get :locations do
	    location_manager.all
	  end

		desc "Create a location."
    params do
      requires :name, type: String, desc: "location name"
      requires :address, type: String, desc: "location address"
    end
	  post :location do
	  	location_manager.create params[:name], params[:address]
	  end

	  desc "Delete a location."
	  params do
	  	requires :id, type: Integer, desc: "Location id"
	  end
	  delete 'locations/:id' do
	  	error!('not found!', 404) if not location_manager.delete(params[:id])
	  end
	end
end