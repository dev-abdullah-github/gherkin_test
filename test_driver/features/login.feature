Feature: Login Screen

    Enter email and password to screen and then login

    # Scenario: when email and password entered and login is clicked
    #     Given I have 'emailfield' and 'passwordfield' and 'loginButton'
    #     When I fill the 'emailfield' with 'ma@mail.com'
    #     And I fill the '123456' with '123456'
    #     Then I tap the 'loginButton' button
    #     Then I should have 'HomePage' on screen

    Scenario: when email and password entered and login is clicked
        Given I have emailfield and passwordfield and loginButton
        When I fill the emailfield and password field
        And I tap the loginButton button
        Then I should have HomePage on screen
        Then I tap logout button and I back to loginscreen