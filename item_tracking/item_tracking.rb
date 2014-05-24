#!/usr/bin/ruby
require 'grape'
require 'json'

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
		end

		def create(name, location_id)
		end

		def delete(item_id)
		end
	end

	class API < Grape::API
		format :json

		item_manager = ItemManager.new
		
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
	    #not implemented yet
	  end

	  desc "delete item"
	  params do
	  	requires :id, type: Integer, desc: "item id"
	  end
	  delete :item do
	    #not implemented yet
	  end
	end
end