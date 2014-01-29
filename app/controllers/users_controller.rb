class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => [:home]
	def index

	end


	def home
		render "home"
	end

	def my_profile 

	end
end