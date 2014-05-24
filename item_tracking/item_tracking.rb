#!/usr/bin/ruby
require 'grape'

module ItemTracking
	class API < Grape::API
		format :json
		
	  get :items do
	    {hello: "world"}
	  end

	  post :items do
	    {hello: "world"}
	  end

	  #params: id
	  delete :item do
	    {hello: "world"}
	  end
	end
end