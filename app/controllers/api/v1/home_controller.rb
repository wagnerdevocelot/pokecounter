class Api::V1::HomeController < ApplicationController
  def index
    # types = Type.all
    # # return only the types that have "bug" or "grass" on field double_damage_to
    # types = types.select { |t| t.double_damage_to.include?("bug") and t.double_damage_to.include?("grass") }

    types = Pokemon.all.map {|pokemon| {id: pokemon.id, name: pokemon.name} }
    render json: types
  end

  def search
    id = params[:id]

    pokemons = Services::TypeService.new.busca(id)

    render json: pokemons
  end
end


