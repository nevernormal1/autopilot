Feature: System sends backlog

  As a user with a pivotal project
  I want the system to email me the backlog nightly
  So that I can prioritize the queue

  Scenario: Send items in backlog
    Given I have the following project:
      | Name  | API Key | Email                       |
      | fbolt | ABCD    | development@inventables.com |
    And my project has the following stories in the backlog:
      | Name           | Description                      | Estimate | Type    | Current State |
      | Variety widget | Show varieties in a table        | 1        | feature | unstarted     |
      | Footer is belt | Expected a footer but got a belt | -1       | bug     | unstarted     |
    When the notifier runs
    Then an email should be sent to "development@inventables.com"
    And the email should include the following copy:
    """
    There are 2 cards in the backlog prioritized as follows:

    1. Variety widget (1 point feature)
    Show varieties in a table

    2. Footer is belt (bug)
    Expected a footer but got a belt
    """

