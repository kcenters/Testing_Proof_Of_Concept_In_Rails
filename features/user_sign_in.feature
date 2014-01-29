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