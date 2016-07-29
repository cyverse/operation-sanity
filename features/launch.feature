# This feature launches all of the featured images on all of the providers of Atmosphere and ensures they get to the networking step
# Ensuring that instances get to the networking step is necessary, otherwise a modal will continuously pop up demanding you put 
# instances into a project, breaking all scripts.

Feature: Launch all featured images

    Background:
        Given a browser

    Scenario Outline: Launch all featured images
        When I resize the browser to 5000x5000
        # Login
        When I login to Atmosphere
        # Create project
        Then I create project "<project-name>" if necessary
        # Launch instance
        Then I should see and press "Dashboard" within 10 seconds
        Then I should see and press "Launch New Instance" within 10 seconds
        Then I should see "<image>" within 30 seconds
        Then I scroll down <scroll> pixels
        Then I press "<image>"
        When I wait for 5 seconds
        Then I should see and press "Launch" within 10 seconds
        Then I should see "Launch an Instance / Basic Options" within 10 seconds
        And I should see "alloted GBs of Memory" within 10 seconds
        And I choose provider "<provider>" from Provider dropdown
        When I choose "<project-name>" from Project dropdown
        # This button sometimes gives trouble
        And I press "Launch Instance"
        And I wait for 3 seconds
        And I double-check that I press "Launch Instance"
        Then I should see "Networking" within 600 seconds
        And I wait for 30 seconds

    Examples: Featured images
        | image                          | project-name | scroll | provider                       |
        | Ubuntu 14.04.2 XFCE Base       | BDD-01       | 0      | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-02       | 50     | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-03       | 100    | iPlant Workshop Cloud - Tucson​ |
        | functional genomics_v1.0       | BDD-04       | 150    | iPlant Workshop Cloud - Tucson​ |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-05       | 200    | iPlant Workshop Cloud - Tucson​ |

        | Ubuntu 14.04.2 XFCE Base       | BDD-06       | 0      | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-07       | 50     | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-08       | 100    | iPlant Cloud - Tucson​          |
        | functional genomics_v1.0       | BDD-09       | 150    | iPlant Cloud - Tucson​          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-10       | 200    | iPlant Cloud - Tucson​          |

        | Ubuntu 14.04.2 XFCE Base       | BDD-11       | 0      | iPlant Cloud - Austin          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-12       | 50     | iPlant Cloud - Austin          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-13       | 100    | iPlant Cloud - Austin          |
        | functional genomics_v1.0       | BDD-14       | 150    | iPlant Cloud - Austin          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-15       | 420    | iPlant Cloud - Austin          |