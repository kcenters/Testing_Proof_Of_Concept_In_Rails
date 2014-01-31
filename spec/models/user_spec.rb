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
