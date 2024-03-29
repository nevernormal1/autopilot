Feature: System sends backlog

  As a user with a pivotal project
  I want the system to email me the backlog nightly
  So that I can prioritize the queue

  Scenario: Send items in backlog
    Given today is "Sep 30 2011"
    And I have the following project:
      | Name  | Token | Email                       | Pivotal ID |
      | fbolt | ABCD  | development@inventables.com | 1234       |
    And my project has the following stories in the backlog:
      | Name            | Estimate | Type    | Current State |
      | Variety widget  | 1        | feature | unstarted     |
      | Footer is belt  | -1       | bug     | unstarted     |
      | Awesome release |          | release | unstarted     |
    When the notifier runs
    Then "development@inventables.com" should receive an email with subject "fbolt Pivotal Queue: 09/30/2011"
    When they open the email
    Then they should see "There are 2 cards in the backlog prioritized as follows:" in the email body
    And they should see "1. Variety widget (1 point feature)" in the email body
    And they should see "2. Footer is belt (bug)" in the email body
    But they should not see "Awesome release" in the email body

  Scenario: Send items in progress
    Given today is "Sep 30 2011"
    And I have the following project:
      | Name  | Token | Email                       | Pivotal ID |
      | fbolt | ABCD  | development@inventables.com | 1234       |
    And my project has the following stories in progress:
      | Name            | Estimate | Type    | Current State |
      | Variety widget  | 1        | feature | started     |
      | Footer is belt  | -1       | bug     | started     |
      | Awesome release |          | release | started     |
    When the notifier runs
    Then "development@inventables.com" should receive an email with subject "fbolt Pivotal Queue: 09/30/2011"
    When they open the email
    Then they should see "There are 2 cards in progress:" in the email body
    And they should see "1. Variety widget (1 point feature)" in the email body
    And they should see "2. Footer is belt (bug)" in the email body
    But they should not see "Awesome release" in the email body
