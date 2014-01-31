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


Cucumber
==========
1) In your features/support/env.rb file add the following lines

require 'cucumber/formatter/unicode'

require 'webrat'
require 'webrat/core/matchers'
require 'simplecov'

SimpleCov.start


Webrat.configure do |config|
  config.mode = :selenium
  config.application_framework = :external
  config.selenium_server_address = '127.0.0.1'
    # if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/
  config.selenium_browser_startup_timeout = 60
  config.application_address = 'localhost'
  config.application_port = '3000'
end


This setups up the testing envrionment for Selenium using Webrat Also add : 

apybara.register_driver :javascript do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end


This will configure your selenium enviornment to run a firefox browser. If you want it to run in chrome you can chance :firefox to :chrome.

2) Now in the features directory you can create a feature file. In this case I called it user_sign_in.feature. Add the following scenarios: 

Feature: User sign in
	User goes to sign in page and signs in

	Scenario: User that doesn't exist can't sign in
	Given I am a non-existant user on the sign in page
	And I have not registered for the site 
	When I try to log in 
	Then I should be denied access


	Scenario: User signs in successfully 
	Given I am a user that exists
	When I try to log in 
	Then I should be redirected to the my profile page 


	Scenario: User can't access the My Profile page when not signed in
	Given I am a non-existant user on the sign in page
	When I try to access the my_profile page
	Then I should be redirected to the sign in page

	@javascript
	Scenario: User is signed in and uses javascript
	Given I am a user that has logged in
	When I click the show button
	Then content should appear


3) The @javscript will run that particular test in selenium. Now when you run bundle exec cucumber. It will print out the steps to paste in your feature file. Create a feature file called user_sign_in.rb in the features/step_definitions directory and paste the code in there. I've provided the code in the repository needed to get the tests to pass. You can use that as reference testing your cucumbers until they pass. 












