# frozen_string_literal: true

module Api
  module V1
    # HomeController responde recebe e responde requisições do cliente
    class HomeController < ApplicationController
      def pokedex
        pokedex = Services::PokemonService.get_all
        render json: pokedex
      end

      def counters
        pokemon_counters = Services::PokemonService.new.find_counter(params[:id])
        render json: pokemon_counters
      end
    end
  end
end
