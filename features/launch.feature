Feature: Atmosphere launch an instance

  Background:
    Given "Test_user" as the persona

  Scenario: Launch an Instance
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    Then I should see "Launch New Instance" within 5 seconds
    And I press "Launch New Instance"
    Then I should see "Ubuntu 14.04.2 XFCE Base" within 5 seconds
    And I press "Ubuntu 14.04.2 XFCE Base"
    Then I should see "Launch" within 5 seconds
    And I press "Launch"
    Then I should see "Launch Instance" within 5 seconds
    Then I should see "alloted GBs of Memory" within 5 seconds
    And I press "Launch Instance"
    Then I should see "Active" within 600 seconds
