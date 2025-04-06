# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::HomeController, type: :controller do
  describe 'GET #pokedex' do
    it 'returns all pokemon' do
      get :pokedex

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #team_counters' do
    before do
      # Criar tipos para os pokémon
      type_normal = Type.create(name: 'test_normal')
      
      # Criar alguns pokémon que podemos usar para montar o time de teste
      Pokemon.create(name: "pikachu", type_a_id: type_normal.id, hp: 35, attack: 55, defense: 40,
                    special_attack: 50, special_defense: 50, speed: 90, generation: 1, total: 320)
      Pokemon.create(name: "charizard", type_a_id: type_normal.id, hp: 78, attack: 84, defense: 78, 
                    special_attack: 109, special_defense: 85, speed: 100, generation: 1, total: 534)
      Pokemon.create(name: "bulbasaur", type_a_id: type_normal.id, hp: 45, attack: 49, defense: 49,
                    special_attack: 65, special_defense: 65, speed: 45, generation: 1, total: 318)
      Pokemon.create(name: "snorlax", type_a_id: type_normal.id, hp: 160, attack: 110, defense: 65,
                    special_attack: 65, special_defense: 110, speed: 30, generation: 1, total: 540)
      Pokemon.create(name: "gengar", type_a_id: type_normal.id, hp: 60, attack: 65, defense: 60,
                    special_attack: 130, special_defense: 75, speed: 110, generation: 1, total: 500)
      Pokemon.create(name: "gyarados", type_a_id: type_normal.id, hp: 95, attack: 125, defense: 79,
                    special_attack: 60, special_defense: 100, speed: 81, generation: 1, total: 540)
                    
      # Criar mais 20 Pokémon para servir como counters
      20.times do |i|
        Pokemon.create(name: "counter#{i}", type_a_id: type_normal.id, hp: 100, attack: 100, defense: 100,
                      special_attack: 100, special_defense: 100, speed: 100, generation: 1, total: 600)
      end
    end
    
    it 'returns counter team for given pokemon team' do
      valid_team = { team: %w[pikachu charizard bulbasaur snorlax gengar gyarados] }
      post :team_counters, params: valid_team

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an(Array)
      expect(JSON.parse(response.body).length).to eq(6)
    end

    it 'returns error when team is incomplete' do
      invalid_team = { team: %w[pikachu charizard] }
      post :team_counters, params: invalid_team

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to have_key('error')
    end

    it 'returns error when pokemon does not exist' do
      invalid_team = { team: %w[pikachu charizard bulbasaur snorlax gengar nonexistentpokemon] }
      post :team_counters, params: invalid_team

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to have_key('error')
    end
  end
end
