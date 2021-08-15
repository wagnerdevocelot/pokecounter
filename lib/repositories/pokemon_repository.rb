module Repositories
  class PokemonRepository < Pokemon
    def find_by_id(id)
      pokemon = Pokemon.find(id)
    end
  end
end