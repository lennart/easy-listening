Feature: Hello World!
  In Order to check simple functionality
  I need to visit the only page available
  Scenario: I want a greeting
    Given I am a generic user
    When I visit "/"
    Then I should see "Hello World"
