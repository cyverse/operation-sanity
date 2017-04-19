# This feature launches all of the featured images on all of the providers of Atmosphere and ensures they get to the networking step

Feature: Launch all featured images

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
  Scenario Outline: Launch all featured images
    Given a browser
    When I go to "/application/projects"
    Then I should see an element with xpath "//h2[contains(string(), 'BDD-01')]" within 10 seconds
    When I press the element with xpath "//h2[contains(string(), 'BDD-01')]"
    Then I should see an element with xpath "//h1[contains(string(), 'BDD-01')]" within 10 seconds
    And I should skip this scenario if I see an instance with "<image-name>" and provider "<provider>"
    When I go to "/application/images"
    And I migrate resources to project "BDD-01" if necessary
    Then I should see "SEARCH" within 60 seconds
    And I should see an element with the css selector ".form-control" within 10 seconds
    When I type slowly "<image-guid>" to "0" index of class "form-control"
    Then I should see "<image-name>" within 60 seconds
    When I press the element with xpath "//h2[contains(string(), '<image-name>')]"
    Then I should see an element with the css selector ".launch-button" within 10 seconds
    And element with xpath "//button[contains(@class, 'launch-button')]" should be enabled within 5 seconds
    When I press the element with xpath "//button[contains(@class, 'launch-button')]"
    And I should see "Launch an Instance / Basic Options" within 60 seconds
    And I should see "alloted GBs of Memory" within 10 seconds
    When I choose option "<provider>" from dropdown with label "Provider"
    And I choose option "<size>" from dropdown with label "Instance Size"
    And I choose option "BDD-01" from dropdown with label "Project"
      # This button sometimes gives trouble
    And I press "Launch Instance"
    And I wait for 10 seconds
    And I double-check that I press "Launch Instance"
    And I wait up to 90 seconds for instance with name "<image-name>" and provider "<provider>" to finish building
    Examples: Selected images
      | image-guid                           | image-name                     | provider                       | size                                      |
      | c3ff7e02-98d1-43c9-b84f-9f7cd79bec4d | Ubuntu 12.04 Unity GUI v1      | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |
      | d559c236-53ef-437a-999e-02ae16c4b5f0 | Ubuntu 14.04.2 XFCE Base       | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |
      | 524bd34b-5579-4f7e-958b-172ff6c403db | CyVerse CentOS 6.8 GUI Base    | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |
      | 5de53056-9448-4519-b9b7-74dde60b9905 | Ubuntu 14.04 with Docker 1.7.x | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |
      | 7a7f187f-a5dc-4c23-8197-ed3f114a1a2c | functional genomics_v1.0       | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |
      | 538537d7-b243-463c-b156-86b9e965bb88 | Software Carpentry 06-07-2016  | iPlant Cloud - Tucson          | tiny1 (CPU: 1, Mem: 4 GB, Disk: 30 GB)    |

      # Note "Ubuntu 12.04 Unity GUI v1" does not exist on Austin
#      | d559c236-53ef-437a-999e-02ae16c4b5f0 | Ubuntu 14.04.2 XFCE Base       | iPlant Cloud - Austin          | tiny (CPU: 1, Mem: 4 GB)                  |
#      | 524bd34b-5579-4f7e-958b-172ff6c403db | CyVerse CentOS 6.8 GUI Base    | iPlant Cloud - Austin          | tiny (CPU: 1, Mem: 4 GB)                  |
#      | 5de53056-9448-4519-b9b7-74dde60b9905 | Ubuntu 14.04 with Docker 1.7.x | iPlant Cloud - Austin          | tiny (CPU: 1, Mem: 4 GB)                  |
#      | 7a7f187f-a5dc-4c23-8197-ed3f114a1a2c | functional genomics_v1.0       | iPlant Cloud - Austin          | tiny (CPU: 1, Mem: 4 GB)                  |
#      | 538537d7-b243-463c-b156-86b9e965bb88 | Software Carpentry 06-07-2016  | iPlant Cloud - Austin          | tiny (CPU: 1, Mem: 4 GB)                  |

#      | c3ff7e02-98d1-43c9-b84f-9f7cd79bec4d | Ubuntu 12.04 Unity GUI v1      | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
#      | d559c236-53ef-437a-999e-02ae16c4b5f0 | Ubuntu 14.04.2 XFCE Base       | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
#      | 524bd34b-5579-4f7e-958b-172ff6c403db | CyVerse CentOS 6.8 GUI Base    | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
#      | 5de53056-9448-4519-b9b7-74dde60b9905 | Ubuntu 14.04 with Docker 1.7.x | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
#      | 7a7f187f-a5dc-4c23-8197-ed3f114a1a2c | functional genomics_v1.0       | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
#      | 538537d7-b243-463c-b156-86b9e965bb88 | Software Carpentry 06-07-2016  | iPlant Workshop Cloud - Tucson | small2 (CPU: 2, Mem: 16 GB), Disk: 120 GB |
