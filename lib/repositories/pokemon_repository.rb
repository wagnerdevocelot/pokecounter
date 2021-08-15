module Repositories
  class PokemonRepository < Pokemon
    def get_all
      pokemons = Pokemon.all

      return pokemons.map {|pokemon| {id: pokemon.id, name: pokemon.name}}
    end

    def find_by_id(id)
      pokemon = Pokemon.find(id)
    end
  end
end