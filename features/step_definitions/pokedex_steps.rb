# frozen_string_literal: true

Given('A Pokedex endpoint') do
  # pokedex endpoint
  @pokedex_path = 'http://localhost:3000/api/v1/home/pokedex'
end

When('I send a GET request to the Pokedex resource') do
  # Make a GET request to the Pokedex resource
  @response = HTTParty.get(@pokedex_path)
end

Then('I should receive a {int} OK response') do |int|
  # Check the response code
  expect(@response.code).to eq(int)
end
