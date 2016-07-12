# This features provides as much standalone ticketing as possible:
# * Request more resources
# * Atmosphere feedback
#
# The other ticketing scenarioes are, which are included in cloud.feature:
# * Report an instance
# * Report a volume

Feature: Atmosphere "Need more?" resource request

  Background:
    Given "Test_user" as the persona

  Scenario: Request More Resources
    When I login to Atmosphere
    Then I should see and press "Need more?" within 30 seconds
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