Feature: Atmosphere "Need more?" resource request

  Background:
    Given "Test_user" as the persona

  Scenario: Request More Resources
    When I login to Atmosphere
    Then I should see "Need more?" within 30 seconds
    And I press "Need more?"
    Then I should see "Request Resources" within 30 seconds
    And I ask for "0 AU" resources for "This is an automated feedback test. Please delete me." reason
    And I press "Request Resources"
    Then I should see "Resource Request submitted" within 30 seconds

  Scenario: Enter Atmosphere Feedback
    When I login to Atmosphere
    And I press "Feedback"
    Then I should see "Are you experiencing a problem" within 10 seconds
    And I type "This is an automated feedback test. Please delete me." to class "form-control"
    And I press "Send feedback"
    Then I should see "Thanks for your feedback!" within 20 seconds