Feature: Atmosphere attach a volume

  Background:
    Given a browser
    Given "Test_user" as the persona

  Scenario: Attach a Volume
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    And I press "Projects"
    Then I should see "Test-Project" within 5 seconds
    And I press "Test-Project"
    And I press "New"
    And I press "Volume"
    Then I should see "Create volume" within 5 seconds
    And I type "New-Volume-Name" to class "form-control"
    And I press "Create volume"
    Then I should see "New-Volume-Name" within 5 seconds
    And I press "New-Volume-Name"
    Then I should see "Attach" within 5 seconds
    And I press Attach
    Then I should see "Attach volume to instance" within 5 seconds
    And I press "Attach volume to instance"
    Then I should see "Attached To " within 20 seconds

