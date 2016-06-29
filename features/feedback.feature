Feature: Atmosphere feedback form

  Background:
    Given a browser
    Given "Test_user" as the persona

  Scenario: Enter Atmosphere Feedback
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    And I press "Feedback"
    Then I should see "Are you experiencing a problem" within 5 seconds
    And I type "This is an automated feedback test. Please delete me." to class "form-control"
    And I press "Send feedback"
    Then I should see "Thanks for your feedback!" within 5 seconds
