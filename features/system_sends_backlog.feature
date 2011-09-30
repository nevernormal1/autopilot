Feature: System sends backlog

  As a user with a pivotal project
  I want the system to email me the backlog nightly
  So that I can prioritize the queue

  Scenario: Send items in backlog
    Given I have the following project:
      | Name  | Token | Email                       |
      | fbolt | ABCD  | development@inventables.com |
    And my project has the following stories in the backlog:
      | Name           | Description                      | Estimate | Type    | Current State |
      | Variety widget | Show varieties in a table        | 1        | feature | unstarted     |
      | Footer is belt | Expected a footer but got a belt | -1       | bug     | unstarted     |
    When the notifier runs
    Then "development@inventables.com" should receive an email with subject "Your fbolt backlog"
    When they open the email
    Then they should see "There are 2 cards in the backlog prioritized as follows:" in the email body
    And they should see "1. Variety widget (1 point feature)" in the email body
    And they should see "Show varieties in a table" in the email body
    And they should see "2. Footer is belt (bug)" in the email body
    And they should see "Expected a footer but got a belt" in the email body

