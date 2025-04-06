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
