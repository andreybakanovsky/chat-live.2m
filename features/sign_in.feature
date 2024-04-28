Feature: Sign In
  As a registered user
  I want to be able to sign in
  So that I can access my account

  Scenario: Successful sign in
    Given I have a registered account
    When I sign in with valid credentials
    Then I should be redirected to the root page

  Scenario: Unsuccessful sign in
    Given I have a registered account
    When I sign in with invalid credentials
    Then I should be redirected to the new session page
