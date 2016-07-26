Feature: Test web shells of featured images

    Background:
        Given a browser

    Scenario Outline: Check web shell
        # Login
        When I login to Atmosphere

        # Check that instance is active
        Then I should see and press "Projects" within 30 seconds
        Then I scroll down <scroll> pixels
        Then I should see and press "<project-name>" within 30 seconds
        Then I wait for instance to become active

        # Web shell checking has been commented out because the web shell has been disabled recently

        # Check web shell
        #Then I should see and press "<image>" within 30 seconds
        #Then I enter the Web Shell
        #Then I should see "Access is restricted to AUTHORIZED USERS only!" within 30 seconds

    Examples: Featured images
        | image                          | project-name | scroll        | provider                       |
        | Ubuntu 14.04.2 XFCE Base       | BDD-1        | 0             | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-2        | 600           | iPlant Workshop Cloud - Tucson​ |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-3        | 600           | iPlant Workshop Cloud - Tucson​ |
        | functional genomics_v1.0       | BDD-4        | 900           | iPlant Workshop Cloud - Tucson​ |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-5        | 900           | iPlant Workshop Cloud - Tucson​ |

        | Ubuntu 14.04.2 XFCE Base       | BDD-6        | 900           | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-7        | 1200          | iPlant Cloud - Tucson​          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-8        | 1200          | iPlant Cloud - Tucson​          |
        | functional genomics_v1.0       | BDD-9        | 1200          | iPlant Cloud - Tucson​          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-10       | 0             | iPlant Cloud - Tucson​          |

        | Ubuntu 14.04.2 XFCE Base       | BDD-11       | 0             | iPlant Cloud - Austin          |
        | Ubuntu 14.04 with Docker 1.7.x | BDD-12       | 300           | iPlant Cloud - Austin          |
        | Ubuntu 14.04.3 NoGUI Base      | BDD-13       | 300           | iPlant Cloud - Austin          |
        | functional genomics_v1.0       | BDD-14       | 300           | iPlant Cloud - Austin          |
        | iPlant Centos 6.5 NoGUI Base3  | BDD-15       | 600           | iPlant Cloud - Austin          |