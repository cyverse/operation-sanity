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
    Then I create project "<project-name>" if necessary
    # Launch instance
    Then I should see and press "Dashboard" within 10 seconds
    Then I should see and press "Launch New Instance" within 10 seconds
    Then I should see "<image>" within 30 seconds

    Then I scroll down "<scroll>" pixels

    Then I press "<image>"
    When I wait for 5 seconds
    Then I should see and press "Launch" within 10 seconds
    Then I should see "Launch an Instance / Basic Options" within 10 seconds
    # you might have to change this line to "iPlant Workshop Cloud - Tucson"
    And I should see "iPlant Cloud - Tucson" within 10 seconds
    And I choose a provider from Provider dropdown
    When I choose "<project-name>" from Project dropdown
    Then I should see "Launch Instance" within 10 seconds
    Then I should see "alloted GBs of Memory" within 10 seconds
    And I press "Launch Instance"
    Then I should see "Build" within 10 seconds
    Then I should see "Spawning" within 300 seconds
    Then I should see "Networking" within 300 seconds

  Examples: Featured images
    | image                          | project-name  | scroll |
    | Ubuntu 14.04.2 XFCE Base       | project-one   | 0      |
    | Ubuntu 14.04 with Docker 1.7.x | project-two   | 50     |
    | Ubuntu 14.04.3 NoGUI Base      | project-three | 100    |
    | functional genomics_v1.0       | project-four  | 150    |
    | iPlant Centos 6.5 NoGUI Base3  | project-five  | 200    |
