# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::HomeController, type: :controller do
  describe 'GET #pokedex' do
    it 'returns all pokemon' do
      get :pokedex

      expect(response).to have_http_status(:ok)
    end
  end
end
