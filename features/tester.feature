Feature: Atmosphere test the whole cloud!

  Background:
    Given "Test_user" as the persona

  Scenario: Create a project
    When I login to Atmosphere
    Then I see and press "Projects" within 10 seconds
    Then I see and press "Create New Project" within 10 seconds
    Then I should see "Project Name" within 10 seconds
    And I type slowly "BDD-Project" to "0" index of class "form-control"
    And I type slowly "BDD-Project" to "1" index of class "form-control"
    And I press "submitCreateProject"
    Then I should see "BDD-Project" within 10 seconds