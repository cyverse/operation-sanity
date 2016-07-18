# This feature launches 4/5 of the featured images on Atmosphere and ensures they get to the networking step

Feature: Launch all featured images

  Background:
    Given a browser

  Scenario Outline: Launch all featured images
    When I resize the viewport to 5000x5000
    When I resize the browser to 5000x5000
    # Login
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I enter my Atmosphere username and password
    And I press "LOGIN"
    # Create project
    Then I should see "x" within 10 seconds
    And I press the element with xpath "//*[@class='toast-message']"
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "Create New Project" within 10 seconds
    Then I should see "Project Name" within 10 seconds
    And I type slowly "<name>" to "0" index of class "form-control"
    And I type slowly "<name>" to "1" index of class "form-control"
    And I press "submitCreateProject"
    Then I should see "<name>" within 10 seconds
    # Launch instance
    Then I should see and press "Dashboard" within 10 seconds
    Then I should see and press "Launch New Instance" within 10 seconds
    Then I should see and press "<image>" within 10 seconds
    Then I should see and press "Launch" within 10 seconds
    Then I should see "Launch an Instance / Basic Options" within 10 seconds
    And I choose a provider from Provider dropdown
    When I choose "<name>" from Project dropdown
    Then I should see "Launch Instance" within 10 seconds
    Then I should see "alloted GBs of Memory" within 10 seconds
    And I press "Launch Instance"
    Then I should see "Build" within 10 seconds
    Then I should see "Spawning" within 300 seconds
    Then I should see "Networking" within 300 seconds

  Examples: Featured images
    | image                          | name          |
    | Ubuntu 14.04.2 XFCE Base       | project-one   |
    | Ubuntu 14.04 with Docker 1.7.x | project-two   |
    | Ubuntu 14.04.3 NoGUI Base      | project-three |
    | functional genomics_v1.0       | project-four  |
    #| iPlant Centos 6.5 NoGUI Base3  | project-five  | broken due to scrolling