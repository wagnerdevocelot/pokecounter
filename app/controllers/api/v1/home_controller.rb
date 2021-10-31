# frozen_string_literal: true

module Api
  module V1
    # HomeController responde recebe e responde requisicoes do cliente
    class HomeController < ApplicationController
      def pokedex
        pokedex = Repositories::PokemonRepository.new.all_pokemon
        render json: pokedex
      end

      def counters
        pokemon_counters = if params[:legendary] == 'true'
                             Services::PokemonService.new.non_legendary_counter(params[:id])
                           else
                             Services::PokemonService.new.find_counter(params[:id])
                           end
        render json: pokemon_counters
      rescue StandardError => e
        render json: { error: e.message }, status: :not_found
      end
    end
  end
end
