Testing_Proof_Of_Concept_In_Rails
=================================

A simple testing implementation with Rspec, Cucumber, FactoryGirl, and Selenium 

Background
=================================
This is an excercise for setting up testing environments in rails. 


Getting Started
=================================
1) First you create your application. Run this commmand "rails new testing_proof_of_concept_in_rails" 
2) In your newly created directory add this block of code to your gemfile: 

group :test, :development do
	gem "rspec-rails", "~> 2.14.1"
	gem 'factory_girl_rails'
  gem "launchy"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem "capybara", '1.1.4'
  gem "webrat"
  gem "selenium-client"
  gem "selenium-webdriver"
end

gem "devise", "~> 3.2.2"
gem "twitter-bootstrap-rails", '2.2.6'
gem 'simplecov', :require => false, :group => :test

3) Now run the command "bundle install", and your gems will be installed. 

4) Now you will need to run auto generate commands to setup your cucumber and rspec directories. Run these commands: 

  rails g cucumber:install
  rails generate rspec:install
  rails generate devise_install
  rails g devise:views
  rails generate devise User


Now you're on your own. Good luck. :) Just kidding


Rspec
==========================
1) Add these lines to the top of your spec/spec_helper.rb file.  
  
  require 'simplecov'
  SimpleCov.start
  
  These lines will show the test coverage frmo the simplecov gem. 
  
2) In the same file also add these lines below "require 'rspec/autorun'"

  require 'factory_girl'
  require 'capybara/rspec'
  
  These lines will now alow you to use capybara and factorygirl to create data. 
  
3) Now you can create factories using factory girl. Create a directory called "factories" in the spec directory. Then create a file called user.rb and add the following lines 

  FactoryGirl.define do
	factory :user do
		first_name "Bill"
		last_name "Walker"
		email "billwalker@gmail.com"
		password "password"
	end
end

4)  Now go to spec/models and open up user_spec.rb. If it's not created, then create it. After that, just add the following lines: 

require 'spec_helper'

describe User do
  	it "should not allow the user to be created if all required fields not met" do 
  	 @user = FactoryGirl.create(:user)
  	 @user.first_name = nil
  	 @user.last_name = nil
  	 @user.should_not be_valid
  	end

  	it "should create a valid user" do 
  		@user = FactoryGirl.create(:user)
  		@user.should be_valid
  	end
end

5) Now if you run bundle exec rspec in the command line your test should fail. Your first failure will tell you that the first_name and the last_name fields do not exist. You will have to create a migration file for it. 

rails generate migration add_columns_to_user first_name:string last_name:string
rake db:test:prepare

Now if you run your rspec tests again you will get another error telling you the user passed validations without filling in the first_name and last_name being nil. 

To fix this go to your user.rb file in apps/models/user.rb and add the following lines below the devise lines. 

validates_presence_of :first_name
validates_presence_of :last_name

Now when you run bundle exec rspec again all your tests will pass. Congrats. 











