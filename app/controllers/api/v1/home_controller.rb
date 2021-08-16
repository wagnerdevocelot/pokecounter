class Api::V1::HomeController < ApplicationController
  def index
    pokemons = Services::PokemonService.new.get_all()

    render json: pokemons
  end

  def search
    id = params[:id]

    pokemon = Services::PokemonService.new.find_counter(id)

    render json: pokemon
  end
end


