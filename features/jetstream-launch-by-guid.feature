# This feature launches all of the featured images on all of the providers of Jetstream and ensures they get to the networking step

Feature: Launch all featured images

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
  Scenario Outline: Launch all featured images
    Given a browser
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), 'BDD-01')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), 'BDD-01')]"
    Then I should see an element with xpath "//h1[contains(string(), 'BDD-01')]" within 10 seconds
    And I should skip this scenario if I see an instance with "<image-name>" and provider "<provider>"
    When I go to "/application/images"
    And I migrate resources to project "BDD-01" if necessary
    Then I should see "SEARCH" within 60 seconds
    And I should see an element with the css selector ".form-control" within 10 seconds
    When I type slowly "<image-guid>" to "0" index of class "form-control"
    Then I should see "<image-name>" within 60 seconds
    When I press the element with xpath "//h2[contains(string(), '<image-name>')]"
    Then I should see an element with the css selector ".launch-button" within 10 seconds
    And element with xpath "//button[contains(@class, 'launch-button')]" should be enabled within 5 seconds
    When I press the element with xpath "//button[contains(@class, 'launch-button')]"
    And I should see "Launch an Instance / Basic Options" within 60 seconds
    And I should see "alloted GBs of Memory" within 10 seconds
    When I choose option "<provider>" from dropdown with label "Provider"
    And I choose option "<size>" from dropdown with label "Instance Size"
    And I choose option "BDD-01" from dropdown with label "Project"
      # This button sometimes gives trouble
    And I press "Launch Instance"
    And I wait for 10 seconds
    And I double-check that I press "Launch Instance"
    And I wait up to 90 seconds for instance with name "<image-name>" and provider "<provider>" to finish building
    Examples: Selected images
      | image-guid                           | image-name                     | provider                       | size      |
      | 30f31162-2a7a-4ac5-be1a-45c7e579a04b | Ubuntu 14.04.3 Development GUI | Jetstream - Indiana University | m1.small  |
      | 30f31162-2a7a-4ac5-be1a-45c7e579a04b | Ubuntu 14.04.3 Development GUI | Jetstream - TACC               | m1.small  |
      | 4c25454d-8716-4cd5-841d-d00981536170 | Centos 7 (7.3) Development GUI | Jetstream - Indiana University | m1.small  |
      | 4c25454d-8716-4cd5-841d-d00981536170 | Centos 7 (7.3) Development GUI | Jetstream - TACC               | m1.small  |
      | 66322719-5bfa-4646-93c6-0132e9a958e5 | R with Intel compilers         | Jetstream - Indiana University | m1.small  |
      | 66322719-5bfa-4646-93c6-0132e9a958e5 | R with Intel compilers         | Jetstream - TACC               | m1.small  |
      | 798830e0-9053-4700-a3bd-4acda9935cc2 | CentOS 6 (6.8) Development GUI | Jetstream - Indiana University | m1.small  |
      | 798830e0-9053-4700-a3bd-4acda9935cc2 | CentOS 6 (6.8) Development GUI | Jetstream - TACC               | m1.small  |
      | 906e09cf-2827-49c5-82fd-ea74aa527e1d | BioLinux 8                     | Jetstream - Indiana University | m1.small  |
      | 906e09cf-2827-49c5-82fd-ea74aa527e1d | BioLinux 8                     | Jetstream - TACC               | m1.small  |
      | 73c161ae-2ad9-4379-87c4-0f05692be60b | MATLAB (Based on CentOS 6)     | Jetstream - Indiana University | m1.medium |
      | 73c161ae-2ad9-4379-87c4-0f05692be60b | MATLAB (Based on CentOS 6)     | Jetstream - TACC               | m1.medium |
