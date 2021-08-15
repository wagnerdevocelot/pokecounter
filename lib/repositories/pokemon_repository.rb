module Repositories
  class PokemonRepository < Pokemon
    def get_all
      pokemons = Pokemon.all

      return pokemons
    end

    def find_by_id(id)
      pokemon = Pokemon.find(id)
    end
  end
end