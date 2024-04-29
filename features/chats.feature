Feature: Home page
  In order to read the page
  As a viewer
  I want to see the home page of my app

  Background:
    Given user is logged in

	Scenario: View chats page
  		Given I am on the home page
  		Then I should see "Welcome to our Live Chat!"
