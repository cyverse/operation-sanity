Feature: Atmosphere create an external link

  Background:
    Given a browser
    Given "Test_user" as the persona

  Scenario: Create external link
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    Then I should see "Projects" within 5 seconds
    And I press "Projects"
    Then I should see "Test-Project" within 5 seconds
    And I press "Test-Project"
    And I press "New"
    And I press "Link"
    Then I should see "Create ExternalLink" within 5 seconds
    And I type slowly "Test-Link" to "0" index of class "form-control"
    And I type slowly "Test-description" to "1" index of class "form-control"
    And I type slowly "https://test.url" to "2" index of class "form-control"
    And I press "Create Link"
    Then I should see "Test-Link" within 5 seconds

