class Api::V1::HomeController < ApplicationController
  def pokedex
    pokedex = Services::PokemonService.new.get_all()

    render json: pokedex
  end

  def counters
    id = params[:id]

    pokemon_counters = Services::PokemonService.new.find_counter(id)

    render json: pokemon_counters
  end
end


