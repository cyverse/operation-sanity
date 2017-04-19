Feature: Delete specified running instances on Jetstream

  @persist_browser
  Scenario: Log into atmosphere
    Given a browser
    When I login to Jetstream

  @persist_browser
  Scenario: Create project
    Given a browser
    And I migrate resources to project "BDD-01" if necessary
    Then I create project "BDD-01" if necessary


  @persist_browser
  Scenario Outline: Delete launched instances
    Given a browser
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), 'BDD-01')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), 'BDD-01')]"
    Then I should see an element with xpath "//h1[contains(string(), 'BDD-01')]" within 10 seconds
    And I wait for 2 seconds
    And I should skip this scenario if I do not see an instance with name "<image-name>" and provider "<provider>"
    When I press the checkbox for name "<image-name>" and provider "<provider>"
    And I press the delete button
    Then I should see an element with xpath "//h1[contains(string(), 'Delete Instance')]" within 2 seconds
    And I should see "The following instance will be shut down and all data will be permanently lost"
    When I press "Yes, delete this instance"
    Then I wait for instance with name "<image-name>" and provider "<provider>" to start deleting

    Examples: Selected images
      | image-name                     | provider                       |
      | Ubuntu 14.04.3 Development GUI | Jetstream - Indiana University |
      | Ubuntu 14.04.3 Development GUI | Jetstream - TACC               |
      | Centos 7 (7.3) Development GUI | Jetstream - Indiana University |
      | Centos 7 (7.3) Development GUI | Jetstream - TACC               |
      | R with Intel compilers         | Jetstream - Indiana University |
      | R with Intel compilers         | Jetstream - TACC               |
      | CentOS 6 (6.8) Development GUI | Jetstream - Indiana University |
      | CentOS 6 (6.8) Development GUI | Jetstream - TACC               |
      | BioLinux 8                     | Jetstream - Indiana University |
      | BioLinux 8                     | Jetstream - TACC               |
      | MATLAB (Based on CentOS 6)     | Jetstream - Indiana University |
      | MATLAB (Based on CentOS 6)     | Jetstream - TACC               |