# This feature tests all of the Atmosphere featured images, designed in such a way to play nicely with behave-parallel:
# * Creates a new project, specific to the image
# * Launches instance
# * [Any new testing can be placed here]
# * Deletes instance
# * Deletes project

Feature: Launch all featured images

  Background:
    Given a browser

  Scenario Outline: Launch then delete instance
    # Login
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I enter my Atmosphere username and password
    And I press "LOGIN"
    # Delete instance
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-<image>" within 10 seconds
    Then I should see and press "BDD-Instance" within 10 seconds
    Then I press Delete span
    Then I should see and press "Yes, delete this instance" within 10 seconds
    Then I should see "Deleting" within 10 seconds
    # Delete project
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-<image>" within 10 seconds
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