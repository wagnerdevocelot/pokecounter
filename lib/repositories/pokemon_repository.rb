# frozen_string_literal: true

module Repositories
  # O PokemonRepository e responsavel por fazer a ligacao entre a aplicacao e a tabela Pokemon.
  class PokemonRepository
    def all_pokemon
      Pokemon.all
    end

    def get_all
      all_pokemon
    end

    def find_by_id(id)
      Pokemon.find(id)
    end

    def find_by_name(name)
      Pokemon.where('lower(name) = ?', name.downcase).first
    end
  end
end
