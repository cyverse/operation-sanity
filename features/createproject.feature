Feature: Atmosphere create a project

  Background:
    Given "Test_user" as the persona

  Scenario: Create a project
    When I login to Atmosphere
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    Then I should see "Projects" within 10 seconds
    And I press "Projects"
    Then I should see "Create New Project" within 10 seconds
    And I press "Create New Project"
    Then I should see "Project Name" within 10 seconds
    And I type slowly "BDD-Project" to "0" index of class "form-control"
    And I type slowly "BDD-Project" to "1" index of class "form-control"
    And I press "submitCreateProject"
    Then I should see "Test-Project" within 10 seconds
