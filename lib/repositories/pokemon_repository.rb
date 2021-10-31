# frozen_string_literal: true

module Repositories
  # O PokemonRepository e responsavel por fazer a ligacao entre a aplicacao e a tabela Pokemon.
  class PokemonRepository
    def all_pokemon
      Pokemon.all
    end

    def find_by_id(id)
      Pokemon.find(id)
    end
  end
end
