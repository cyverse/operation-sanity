# This feature deletes the images and project created by launch_featured.feature

Feature: Delete all featured images

  Background:
    Given a browser

  Scenario Outline: Delete instances and projects
    # Login
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I enter my Atmosphere username and password
    And I press "LOGIN"
    
    Then I should see "x" within 10 seconds
    And I press the element with xpath "//*[@class='toast-message']"
    # Delete instance
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "<name>" within 10 seconds
    Then I should see and press "<image>" within 10 seconds
    Then I press Delete span
    Then I should see and press "Yes, delete this instance" within 10 seconds
    Then I should see "Deleting" within 10 seconds
    # Delete project
    When I wait for 60 seconds
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "<name>" within 10 seconds
    Then I press Options span
    Then I should see and press "Delete Project" within 10 seconds
    Then I should see and press "Yes, delete the project" within 10 seconds

  Examples: Featured images
    | image                          | name          |
    | Ubuntu 14.04.2 XFCE Base       | project-one   |
    | Ubuntu 14.04 with Docker 1.7.x | project-two   |
    | Ubuntu 14.04.3 NoGUI Base      | project-three |
    | functional genomics_v1.0       | project-four  |
    #| iPlant Centos 6.5 NoGUI Base3  | project-five  | broken due to scrolling