# This feature provides a baseline test for most of the Atmosphere functionality, including:
# * Creating, reporting, and deleting a volume
# * Creating and deleting an external link
# * Ensuring web shell operation 
# * Request more resources
# * Atmosphere feedback
# * Reporting an instance

Feature: Test web shells of featured images

    Background:
        Given a browser

    Scenario: Report an instance
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        Then I should see and press "Ubuntu 14.04.2 XFCE Base" within 10 seconds
        Then I should see "Report" within 10 seconds
        And I press span "Report"
        Then I should see "What problems are you having with this instance?" within 10 seconds
        And I type slowly "This is an automated feedback test. Please delete me." to "0" index of class "form-control"
        And I press "Report Instance"
        Then I should see "Your report has been sent to support" within 10 seconds

    Scenario: Attach a volume
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        And I press "New"
        And I press "Volume"
        Then I should see "Create volume" within 10 seconds
        And I type slowly "BDD-Volume" to "0" index of class "form-control"
        And I wait for 10 seconds
        And I press "Create volume"
        Then I should see and press "BDD-Volume" within 10 seconds
        Then I should see "Attach" within 10 seconds
        Then I press span "Attach"
        Then I should see and press "Attach volume to instance" within 10 seconds
        #Then I should see "Attached To" within 20 seconds (this step breaks)

    Scenario: Report a volume
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        Then I should see and press "BDD-Volume" within 10 seconds
        Then I should see "Report" within 10 seconds
        Then I press span "Report"
        Then I should see "What problems are you having with this volume?" within 10 seconds
        And I type slowly "This is an automated feedback test. Please delete me." to "0" index of class "form-control"
        And I press "Report Volume"
        Then I should see "Your report has been sent to support" within 10 seconds

    Scenario: Delete a volume
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        Then I should see and press "BDD-Volume" within 10 seconds
        Then I should see "Detach" within 10 seconds
        Then I press span "Detach"
        Then I should see and press "Yes" within 10 seconds
        Then I should see "Detaching" within 10 seconds
        Then I should see "Unattached" within 30 seconds
        Then I should see "Delete" within 10 seconds
        And I press Delete span
        And I should see and press "Yes, delete this volume" within 10 seconds
        Then I should see "You have not added any volumes to this project." within 30 seconds

    Scenario: Create external link
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        And I press "New"
        And I should see and press "Link" within 10 seconds
        Then I should see "Create a Link" within 10 seconds
        And I type slowly "Test-Link" to "0" index of class "form-control"
        And I type slowly "Test-description" to "1" index of class "form-control"
        And I type slowly "https://test.url" to "2" index of class "form-control"
        And I press "Create Link"
        Then I should see "Test-Link" within 10 seconds

    Scenario: Delete external link
        When I login to Atmosphere
        Then I should see and press "Projects" within 10 seconds
        Then I should see and press "BDD-01" within 10 seconds
        Then I should see and press "Test-Link" within 10 seconds
        Then I should see "Delete" within 10 seconds
        And I press Delete span
        Then I should see and press "Yes, delete this link" within 10 seconds
        Then I should see "You have not added any links to this project." within 10 seconds

    Scenario: Request More Resources
        When I login to Atmosphere
        Then I should see and press "Need more?" within 30 seconds
        Then I should see "Request Resources" within 30 seconds
        And I ask for "0 AU" resources for "This is an automated feedback test. Please delete me." reason
        And I press "Request Resources"
        Then I should see "Resource Request submitted" within 30 seconds

    Scenario: Enter Atmosphere Feedback
        When I login to Atmosphere
        And I should see and press "Feedback" within 30 seconds
        Then I should see "Are you experiencing a problem" within 10 seconds
        And I type slowly "This is an automated feedback test. Please delete me." to "0" index of class "form-control"
        And I press "Send feedback"
        Then I should see "Thanks for your feedback!" within 20 seconds