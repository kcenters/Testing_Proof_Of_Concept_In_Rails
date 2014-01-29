Given(/^I am a non\-existant user on the sign in page$/) do
	visit ""
  current_url.should == "http://www.example.com/"
  click_link "sign in"
  current_url.should ==  "http://www.example.com/users/sign_in"
end

Given(/^I have not registered for the site$/) do
  @user = User.find_by_email("billwalker@gmail.com")
  @no_user.should be_blank 
end

When(/^I try to log in$/) do
	fill_in "user_email", with: "billywalker@gmail.com"
	fill_in "user_password", with: "password"
  within ".sign_in_div" do
 	  click_on "Sign in"
  end
end

Then(/^I should be denied access$/) do
  current_url.should_not == "http://www.example.com/users/1/my_profile"
end

Given(/^I am a user that exists$/) do
  @user =  User.create(first_name: "Billy", last_name: "Walker", email: "billywalker@gmail.com", password: "password", password_confirmation: "password")
  visit ""
  current_url.should == "http://www.example.com/"
  click_link "sign in"
  current_url.should ==  "http://www.example.com/users/sign_in"
end

Then(/^I should be redirected to the my profile page$/) do
  current_url.should == "http://www.example.com/users/#{@user.id}/my_profile"
end

When(/^I try to access the my_profile page$/) do
  visit "http://www.example.com/users/1/my_profile"
end

Then(/^I should be redirected to the sign in page$/) do
  current_url.should ==  "http://www.example.com/users/sign_in"
end

Given(/^I am a user that has logged in$/) do
  @user =  User.create(first_name: "Billy", last_name: "Walker", email: "billywalker@gmail.com", password: "password", password_confirmation: "password")
  visit "/"
  click_link "sign in"
  fill_in "user_email", with: "billywalker@gmail.com"
  fill_in "user_password", with: "password"
  within ".sign_in_div" do
    click_on "Sign in"
  end
end

When(/^I click the show button$/) do
  page.should have_selector('#balling_baby', visible: false)
  click_button "Show Profile"
end

Then(/^content should appear$/) do
  page.should have_selector('#balling_baby', visible: true)
end
