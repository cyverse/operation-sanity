Feature: Launch all featured images

  Background:
    Given "Test_user" as the persona

  Scenario Outline: Launch then delete instance
    # Create project
    When I visit "$Atmosphere"
    And I press "Login"
    And I fill in "username" with "$username"
    And I fill in "password" with "$password"
    And I press "LOGIN"
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "Create New Project" within 10 seconds
    Then I should see "Project Name" within 10 seconds
    And I type slowly "BDD-Project" to "0" index of class "form-control"
    And I type slowly "BDD-Project" to "1" index of class "form-control"
    And I press "submitCreateProject"
    Then I should see "BDD-Project" within 10 seconds
    # Launch instance
    When I login to Atmosphere
    Then I should see and press "Launch New Instance" within 10 seconds
    Then I should see and press "<image>" within 10 seconds
    Then I should see and press "Launch" within 10 seconds
    Then I should see "Launch Instance" within 10 seconds
    Then I should see "alloted GBs of Memory" within 10 seconds
    And I press "Launch Instance"
    Then I should see "Build" within 10 seconds
    Then I should see "Spawning" within 120 seconds
    Then I should see "Networking" within 180 seconds
    Then I should see "Deploying" within 3600 seconds
    Then I should see an element with xpath "//*[@class='instance-status-light active']" within 600 seconds
    # Delete instance
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I should see and press "<image>" within 10 seconds
    Then I press Delete span
    Then I should see and press "Yes, delete this instance" within 10 seconds
    Then I should see "Deleting" within 10 seconds
    # Delete project
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I press Options span
    Then I should see and press "Delete Project" within 10 seconds
    Then I should see and press "Yes, delete the project" within 10 seconds

  Examples: Featured images
    | image                          |
    | Ubuntu 14.04.2 XFCE Base       |
    | Ubuntu 14.04 with Docker 1.7.x |
    | Ubuntu 14.04.3 NoGUI Base      |
    | functional genomics_v1.0       |
    | iPlant Centos 6.5 NoGUI Base3  |