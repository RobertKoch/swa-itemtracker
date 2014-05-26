#!/usr/bin/ruby

module ItemTracking
	
	class ItemManager
		def initialize
			@items = []
			@next_id = 1
		end

		def all
			@items
		end

		def find(item_id)
			@items.select {|it| it[:id] == item_id}
		end

		def create(name, location_id)
			item = {
				:name => name,
				:location => location_id,
				:id =>  @next_id

			}

			@items << item
			@next_id += 1

			#return last inserted item
			item
		end

		def delete(item_id)
			if item = self.find(item_id)[0]
				@items.delete item
				true
			else
				false
			end
		end
	end

	class API < Grape::API
		format :json

		item_manager = ItemManager.new

		http_basic do |username, password|
			conn = Faraday.new(:url => 'http://localhost:9191')
	    conn.basic_auth username, password
  		response = conn.get '/user'
  		
  		if response.status != 200
  			error! 'Forbidden', 403
  		else
  			true
  		end
    end
		
		desc "Show all items"
	  get :items do
	    item_manager.all
	  end

	  desc "create new item"
		params do
      requires :name, type: String, desc: "item name"
      requires :location, type: Integer, desc: "item's location id"
    end
	  post :items do
	    item_manager.create params[:name], params[:location]
	  end

	  desc "delete item"
	  params do
	  	requires :id, type: Integer, desc: "item id"
	  end
	  delete :item do
	    error!('not found!', 404) if not item_manager.delete(params[:id])
	  end
	end
end