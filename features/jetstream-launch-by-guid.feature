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
      # Launch instance
    When I go to "/application/images"
    And I migrate resources to project "BDD-01" if necessary
    Then I should see "SEARCH" within 20 seconds
    And I should see an element with the css selector ".form-control" within 10 seconds
    When I type slowly "<image-guid>" to "0" index of class "form-control"
    Then I should see "<image-name>" within 20 seconds
    When I press the element with xpath "//h2[contains(string(), '<image-name>')]"
    Then I should see an element with the css selector ".launch-button" within 10 seconds
    And element with xpath "//button[contains(@class, 'launch-button')]" should be enabled within 5 seconds
    When I press the element with xpath "//button[contains(@class, 'launch-button')]"
    And I should see "Launch an Instance / Basic Options" within 10 seconds
    And I should see "alloted GBs of Memory" within 10 seconds
    When I choose option "<provider>" from dropdown with label "Provider"
    And I choose option "BDD-01" from dropdown with label "Project"
      # This button sometimes gives trouble
    And I press "Launch Instance"
    And I wait for 3 seconds
    And I double-check that I press "Launch Instance"
    And I wait for 10 seconds
    Then I should see "Build" within 60 seconds

    Examples: Selected images
      | image-guid                           | image-name                      | provider                       |
      | 30f31162-2a7a-4ac5-be1a-45c7e579a04b | Ubuntu 14.04.3 Development GUI  | Jetstream - Indiana University |
      | 30f31162-2a7a-4ac5-be1a-45c7e579a04b | Ubuntu 14.04.3 Development GUI  | Jetstream - TACC               |
      | 4301b282-3726-4526-897d-9c9da2fe3057 | CentOS 6 (6.8) Development GUI  | Jetstream - Indiana University |
      | 4301b282-3726-4526-897d-9c9da2fe3057 | CentOS 6 (6.8) Development GUI  | Jetstream - TACC               |
#      | 78e1499d-cc9a-4453-9749-785ae7653010 | CentOS 7 R with Intel compilers | Jetstream - Indiana University |
#      | 78e1499d-cc9a-4453-9749-785ae7653010 | CentOS 7 R with Intel compilers | Jetstream - TACC               |
