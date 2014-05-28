#!/usr/bin/ruby
require 'spec_helper'
require_relative '../lib/reports'

describe Reports::API do

  def app
    Reports::API
  end

  describe Reports::API do
  	
  	describe "authorized" do
  		before do
  			authorize 'paul', 'thepanther'
  		end
  	end

		describe "unauthorized" do
  	end

  end
end