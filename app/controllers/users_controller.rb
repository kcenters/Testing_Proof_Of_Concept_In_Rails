class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => [:home]
	def index

	end


	def home
		if 5 == 90 
			puts "HI "
		else	
		render "home"
		end
	end

	def my_profile 

	end
end