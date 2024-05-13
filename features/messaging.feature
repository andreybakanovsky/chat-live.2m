@javascript

Feature: Messaging between users

  Background:
    Given USER_1 is logged in
    And USER_2 exists
    And USER_3 exists
    And COMMON chat exists


  Scenario: Sending messages between users and common chat
    Given the USER_1 is on the chats page
    Then he should see the user's name
    Then he should see the common chat's name

    When he clicks on the link to USER_2 chat
    Then he can write message "Message 1" to USER_2
    When clicks the send button here in USER_2 chat
    Then he should stay on the current page
    And the "Message 1" should appear in the USER_2 chat

    When USER_1 clicks on the link to COMMON chat
    Then he can write message "Message 2" in COMMON chat
    When clicks the send button here in COMMON chat
    Then the message "Message 2" should appear in COMMON chat

    Then USER_1 is logget out
    And USER_2 is logged in
    Then USER_2 can see the USER_1 chat's name
    And he can see the COMMON chat's name
    When he clicks on the link to USER_1 chat
    Then the "Message 1" appears in the USER_1 chat
    When he clicks on the link to COMMON chat
    Then the "Message 2" appears in the COMMON chat

    Then USER_2 is logget out
    And USER_3 is logged in
    Then USER_3 can see the USER_1 chat's name
    And USER_3 can see the USER_2 chat's name
    And USER_3 can see the COMMON chat's name
    When USER_3 clicks on the link to USER_1 chat
    Then "Message 1" or "Message 2" does not appears in the USER_1 chat
    When USER_3 clicks on the link to USER_2 chat
    Then "Message 1" or "Message 2" does not appears in the USER_2 chat
    When USER_3 clicks on the link to COMMON chat
    Then USER_3 can the "Message 2" appears in the COMMON chat