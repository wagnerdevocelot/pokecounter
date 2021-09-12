Feature: Return a Pokedex with all the Pokemon species in it

Scenario: Get a Pokedex with all the Pokemon species in it
Given A Pokedex endpoint
When I send a GET request to the Pokedex resource
Then I should receive a 200 OK response