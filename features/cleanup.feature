# This feature deletes the images and project created by launch_featured.feature

Feature: Delete all featured images

    Background:
        Given a browser

    Scenario Outline: Delete instances and projects
        When I login to Atmosphere
        # Delete instance
        Then I should see and press "Projects" within 30 seconds
        Then I scroll down 200 pixels
        Then I should see and press "<project-name>" within 10 seconds
        Then I should see and press "<image>" within 10 seconds
        Then I press Delete span
        Then I should see and press "Yes, delete this instance" within 10 seconds
        Then I should see "Deleting" within 10 seconds
        Then I should see "You have not added any instances to this project." within 100 seconds
        Then I wait for 15 seconds
        # Delete project
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "<project-name>" within 10 seconds
        Then I press Options span
        Then I should see and press "Delete Project" within 10 seconds
        Then I should see and press "Yes, delete the project" within 10 seconds

    Examples: Featured images
        | image                          | project-name | scroll | provider                       |
        | Ubuntu 14.04.2 XFCE Base       | BDD-01       | 0      | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-02       | 0      | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-03       | 0      | iPlant Workshop Cloud - Tucson​ |
        | functional genomics_v1.0       | BDD-04       | 100    | iPlant Workshop Cloud - Tucson​ |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-05       | 100    | iPlant Workshop Cloud - Tucson​ |

        | Ubuntu 14.04.2 XFCE Base       | BDD-06       | 100    | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-07       | 200    | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-08       | 200    | iPlant Cloud - Tucson​          |
        | functional genomics_v1.0       | BDD-09       | 200    | iPlant Cloud - Tucson​          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-10       | 300    | iPlant Cloud - Tucson​          |

        | Ubuntu 14.04.2 XFCE Base       | BDD-11       | 300    | iPlant Cloud - Austin          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-12       | 300    | iPlant Cloud - Austin          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-13       | 400    | iPlant Cloud - Austin          |
        | functional genomics_v1.0       | BDD-14       | 400    | iPlant Cloud - Austin          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-15       | 400    | iPlant Cloud - Austin          |
