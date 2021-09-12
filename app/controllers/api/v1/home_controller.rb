# frozen_string_literal: true

module Api
  module V1
    class HomeController < ApplicationController
      def pokedex
        pokedex = Services::PokemonService.get_all

        render json: pokedex
      end

      def counters
        id = params[:id]

        pokemon_counters = Services::PokemonService.new.find_counter(id)

        render json: pokemon_counters
      end
    end
  end
end
