Feature: Atmosphere Request More Resources

  Background:
    Given a browser
    Given "Test_user" as the persona

  Scenario: Request More Resources
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    And I press "Launch New Instance"
    And I press "Ubuntu 14.04.2 XFCE Base"
    And I press "Launch"
    And I press "Launch Instance"
    Then I should see "Suspended" within 20 seconds
