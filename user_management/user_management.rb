#!/usr/bin/ruby
require 'grape'

module UserManagement
	class API < Grape::API
		format :json

		USERS = {}
		USERS['wanda'] = 'partyhard2000'
		USERS['paul'] = 'thepanther'
		USERS['anne'] = 'flytothemoon'
		
		resource :user do
			http_basic do |username, password|
				error!('Forbidden', 403) if not (USERS.include?(username) && USERS[username] == password)
				true
    	end

			get do
			end
		end
	end
end