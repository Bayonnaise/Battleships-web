Feature: Starting the game
	In order to play battleships
	As a nostalgic player
	I want to start a new game

	Scenario: Registering
		Given I am on the homepage
		When I follow "New Game"
		Then I should see "What's your name?"

		Given I am on the player name page
		And I fill in "name" with ""
 		When I press "Submit"
		Then I should see "What's your name?"

		Given I am on the player name page
		And I fill in "name" with "Dave"
 		When I press "Submit"
		Then I should see "Waiting for player 2..."

		

