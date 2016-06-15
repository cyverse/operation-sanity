Feature: Text presence

  Background:
    Given a browser

  Scenario: Search for BDD
    When I visit "https://en.wikipedia.org/"
    And I fill in "search" with "Behavior-driven development"
    And I press "Submit"
    Then I should see "Behavior-driven development" within 5 seconds
