Feature: Atmosphere feedback form

  Background:
    Given a browser

  Scenario: Enter Atmosphere Feedback
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I fill in "username" with "mctesterson"
    And I fill in "password" with "Mctesterson1"
    And I press "LOGIN"
    And I press "Feedback"
    And I set the value of the text area with class "form-control" to "This is a test"
#    And I set the inner HTML of the element with class "form-control" to "This is a test by an automated behave script written by the interns, close me!"
    And I enable the submit feedback button
    And I press "Send feedback"
    Then I should see "Thanks for your feedback!" within 500 seconds
