Feature: Delete specified running instances

  @persist_browser
  Scenario: Log into atmosphere
    Given a browser
    When I login to Atmosphere

  @persist_browser
  Scenario: Create project
    Given a browser
    And I migrate resources to project "BDD-01" if necessary
    Then I create project "BDD-01" if necessary


  @persist_browser
  Scenario Outline: Delete launched instances
    Given a browser
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), 'BDD-01')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), 'BDD-01')]"
    Then I should see an element with xpath "//h1[contains(string(), 'BDD-01')]" within 10 seconds
    And I wait for 2 seconds
    And I should skip this scenario if I do not see an instance with name "<image-name>" and provider "<provider>"
    When I press the checkbox for name "<image-name>" and provider "<provider>"
    And I press the delete button
    Then I should see an element with xpath "//h1[contains(string(), 'Delete Instance')]" within 2 seconds
    And I should see "The following instance will be shut down and all data will be permanently lost"
    When I press "Yes, delete this instance"
    Then I wait for instance with name "<image-name>" and provider "<provider>" to start deleting

    Examples: Selected images
      | image-name                     | provider              |
      | Ubuntu 12.04 Unity GUI v1      | iPlant Cloud - Tucson |
      | Ubuntu 14.04.2 XFCE Base       | iPlant Cloud - Tucson |
      | CyVerse CentOS 6.8 GUI Base    | iPlant Cloud - Tucson |
      | Ubuntu 14.04 with Docker 1.7.x | iPlant Cloud - Tucson |
      | functional genomics_v1.0       | iPlant Cloud - Tucson |
      | Software Carpentry 06-07-2016  | iPlant Cloud - Tucson |

#      | Ubuntu 14.04.3 NoGUI Base      | CyVerse Cloud         |
#      | Ubuntu 14.04 with Docker 1.7.x | CyVerse Cloud         |

#      | Ubuntu 14.04.2 XFCE Base       | iPlant Cloud - Austin          |
#      | CyVerse CentOS 6.8 GUI Base    | iPlant Cloud - Austin          |
#      | Ubuntu 14.04 with Docker 1.7.x | iPlant Cloud - Austin          |
#      | functional genomics_v1.0       | iPlant Cloud - Austin          |
#      | Software Carpentry 06-07-2016  | iPlant Cloud - Austin          |
#
#      | Ubuntu 12.04 Unity GUI v1      | iPlant Workshop Cloud - Tucson |
#      | Ubuntu 14.04.2 XFCE Base       | iPlant Workshop Cloud - Tucson |
#      | CyVerse CentOS 6.8 GUI Base    | iPlant Workshop Cloud - Tucson |
#      | Ubuntu 14.04 with Docker 1.7.x | iPlant Workshop Cloud - Tucson |
#      | functional genomics_v1.0       | iPlant Workshop Cloud - Tucson |
#      | Software Carpentry 06-07-2016  | iPlant Workshop Cloud - Tucson |