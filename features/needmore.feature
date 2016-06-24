Feature: Atmosphere feedback form

  Background:
    Given a browser

  Scenario: Enter Atmosphere Feedback
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I fill in "username" with "robertwalters"
    And I fill in "password" with "Nice_memory_rival_7"
    And I press "LOGIN"
    And I press "Need More?"
    And I set the inner HTML of the element with class "form-control" to "This is a test by an automated behave script written by the interns, close me!"
    And I press "Send feedback"
    Then I should see "Thanks for your feedback!" within 20 seconds
