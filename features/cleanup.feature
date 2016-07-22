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
    # Delete instance
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "<project-name>" within 10 seconds
    Then I should see and press "<image>" within 10 seconds
    Then I press Delete span
    Then I should see and press "Yes, delete this instance" within 10 seconds
    Then I should see "Deleting" within 10 seconds
    # Delete project
    When I wait for 60 seconds
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "<project-name>" within 10 seconds
    Then I press Options span
    Then I should see and press "Delete Project" within 10 seconds
    Then I should see and press "Yes, delete the project" within 10 seconds

  Examples: Featured images
    | image                          | project-name | scroll | provider                       |
    | Ubuntu 14.04.2 XFCE Base       | BDD-1        | 0      | iPlant Workshop Cloud - Tucson​ |
    | Ubuntu 14.04 with Docker 1.7.x | BDD-2        | 100    | iPlant Workshop Cloud - Tucson​ |
    | Ubuntu 14.04.3 NoGUI Base      | BDD-3        | 200    | iPlant Workshop Cloud - Tucson​ |
    | functional genomics_v1.0       | BDD-4        | 300    | iPlant Workshop Cloud - Tucson​ |
    | iPlant Centos 6.5 NoGUI Base3  | BDD-5        | 400    | iPlant Workshop Cloud - Tucson​ |

    | Ubuntu 14.04.2 XFCE Base       | BDD-6        | 0      | iPlant Cloud - Tucson​          |
    | Ubuntu 14.04 with Docker 1.7.x | BDD-7        | 100    | iPlant Cloud - Tucson​          |
    | Ubuntu 14.04.3 NoGUI Base      | BDD-8        | 200    | iPlant Cloud - Tucson​          |
    | functional genomics_v1.0       | BDD-9        | 300    | iPlant Cloud - Tucson​          |
    | iPlant Centos 6.5 NoGUI Base3  | BDD-10       | 400    | iPlant Cloud - Tucson​          |

    | Ubuntu 14.04.2 XFCE Base       | BDD-11       | 0      | iPlant Cloud - Austin          |
    | Ubuntu 14.04 with Docker 1.7.x | BDD-12       | 100    | iPlant Cloud - Austin          |
    | Ubuntu 14.04.3 NoGUI Base      | BDD-13       | 200    | iPlant Cloud - Austin          |
    | functional genomics_v1.0       | BDD-14       | 300    | iPlant Cloud - Austin          |
    | iPlant Centos 6.5 NoGUI Base3  | BDD-15       | 400    | iPlant Cloud - Austin          |