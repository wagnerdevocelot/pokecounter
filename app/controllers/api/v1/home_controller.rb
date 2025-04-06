# frozen_string_literal: true

module Api
  module V1
    # HomeController responde recebe e responde requisicoes do cliente ok
    class HomeController < Api::V1::BaseController
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

      def team_counters
        team = params[:team]
        
        # Verificar se o time foi enviado e se possui elementos
        if team.nil? || team.empty?
          render json: { error: 'É necessário enviar um time de Pokémon' }, status: :bad_request
          return
        end

        # Obter counters para o time
        counter_team = Services::PokemonService.new.find_team_counters(team)
        render json: counter_team
      rescue StandardError => e
        if e.message.include?('Um time completo precisa ter 6 Pokémon')
          render json: { error: e.message }, status: :bad_request
        else
          render json: { error: e.message }, status: :not_found
        end
      end
    end
  end
end
