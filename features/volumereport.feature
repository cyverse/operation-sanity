Feature: Atmosphere report an instance

  Background:
    Given a browser
    Given "Test_user" as the persona

  Scenario: Report an Instance
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    Then I should see "Launch New Instance" within 5 seconds
    And I press "Projects"
    Then I should see "Test-Project" within 5 seconds
    And I press "Test-Project"
    Then I should see "Test-Volume" within 5 seconds
    And I press "Test-Volume"
    Then I should see "Report" within 5 seconds
    And I press Report
    Then I should see "What problems are you having with this volume?" within 5 seconds
    And I type "This is an automated feedback test. Please delete me." to class "form-control"
    And I press "Report Volume"
    Then I should see "Your report has been sent to support" within 5 seconds
