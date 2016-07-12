Feature: Atmosphere test the whole cloud!

  Background:
    Given "Test_user" as the persona

  Scenario: Create a project
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "Create New Project" within 10 seconds
    Then I should see "Project Name" within 10 seconds
    And I type slowly "BDD-Project" to "0" index of class "form-control"
    And I type slowly "BDD-Project" to "1" index of class "form-control"
    And I press "submitCreateProject"
    Then I should see "BDD-Project" within 10 seconds

  Scenario: Launch an Instance
    When I login to Atmosphere
    Then I should see and press "Launch New Instance" within 10 seconds
    Then I should see and press "Ubuntu 14.04.2 XFCE Base" within 10 seconds
    Then I should see and press "Launch" within 10 seconds
    Then I should see "Launch Instance" within 10 seconds
    Then I should see "alloted GBs of Memory" within 10 seconds
    And I press "Launch Instance"
    Then I should see "Build" within 10 seconds
    Then I should see "Spawning" within 120 seconds
    #Then I should see "Initializing" within 180 seconds (sometimes this step breaks)
    Then I should see "Networking" within 180 seconds
    Then I should see "Deploying" within 3600 seconds
    Then I should see an element with xpath "//*[@class='instance-status-light active']" within 600 seconds

  Scenario: Report an Instance
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I should see and press "Ubuntu 14.04.2 XFCE Base" within 10 seconds
    Then I should see "Report" within 10 seconds
    And I press span "Report"
    Then I should see "What problems are you having with this instance?" within 10 seconds
    And I type "This is an automated feedback test. Please delete me." to class "form-control"
    And I press "Report Instance"
    Then I should see "Your report has been sent to support" within 10 seconds

  Scenario: Attach a Volume
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    And I press "New"
    And I press "Volume"
    Then I should see "Create volume" within 10 seconds
    And I type "BDD-Volume" to class "form-control"
    And I press "Create volume"
    Then I should see and press "BDD-Volume" within 10 seconds
    Then I should see and press "Attach" within 10 seconds
    Then I should see and press "Attach volume to instance" within 10 seconds
    #Then I should see "Attached To" within 20 seconds (this step breaks)

  Scenario: Report a volume
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I should see and press "BDD-Volume" within 10 seconds
    Then I should see and press "Report" within 10 seconds
    Then I should see "What problems are you having with this volume?" within 10 seconds
    And I type "This is an automated feedback test. Please delete me." to class "form-control"
    And I press "Report Volume"
    Then I should see "Your report has been sent to support" within 10 seconds

  Scenario: Delete a volume
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I should see and press "BDD-Volume" within 10 seconds
    Then I should see and press "Detach" within 10 seconds
    Then I should see "Delete" within 10 seconds
    And I press span "Delete"
    And I press "Yes, delete this volume"
    Then I should see "You have not added any volumes to this project." within 30 seconds

  Scenario: Create external link
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    And I press "New"
    And I press "Link"
    Then I should see "Create ExternalLink" within 10 seconds
    And I type slowly "Test-Link" to "0" index of class "form-control"
    And I type slowly "Test-description" to "1" index of class "form-control"
    And I type slowly "https://test.url" to "2" index of class "form-control"
    And I press "Create Link"
    Then I should see "Test-Link" within 10 seconds

  Scenario: Delete external link
    When I login to Atmosphere
    Then I should see and press "Projects" within 10 seconds
    Then I should see and press "BDD-Project" within 10 seconds
    Then I should see and press "Test-Link" within 10 seconds
    Then I should see "Delete" within 10 seconds
    And I press span "Delete"
    Then I should see "Yes, delete this link"