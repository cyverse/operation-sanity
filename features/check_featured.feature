Feature: Test web shells of featured images

  Background:
    Given a browser

  Scenario Outline: Launch then delete instance
    # Login
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I enter my Atmosphere username and password
    And I press "LOGIN"
    Then I should see and press "Projects" within 30 seconds
    Then I should see and press "BDD-Ubuntu 14.04.2 XFCE Base" within 30 seconds
    Then I should see and press "Ubuntu 14.04.2 XFCE Base" within 30 seconds
    Then I enter the Web Shell
    Then I should see "Access is restricted to AUTHORIZED USERS only!" within 30 seconds

  Examples: Featured images
    | image                          | name          |
    | Ubuntu 14.04.2 XFCE Base       | project-one   |
    | Ubuntu 14.04 with Docker 1.7.x | project-two   |
    | Ubuntu 14.04.3 NoGUI Base      | project-three |
    | functional genomics_v1.0       | project-four  |
    #| iPlant Centos 6.5 NoGUI Base3  | project-five  | broken due to scrolling