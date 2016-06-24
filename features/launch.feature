Feature: Atmosphere feedback form

  Background:
    Given a browser

  Scenario: Enter Atmosphere Feedback
    When I visit "https://atmo.iplantcollaborative.org/application"
    And I press "Login"
    And I fill in "username" with "robertwalters"
    And I fill in "password" with "Nice_memory_rival_7"
    And I press "LOGIN"
    And I press "Images"
    And I press "Ubuntu 14.04.2 XFCE Base"
    And I press "Launch"
    And I press "Launch Instance"
    Then I should see "Suspended" within 20 seconds
