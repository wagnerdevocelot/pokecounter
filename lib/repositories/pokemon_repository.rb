# frozen_string_literal: true

module Repositories
  # O PokemonRepository é responsável por fazer a ligação entre a aplicação e a tabela Pokemon.
  class PokemonRepository
    def get_all
      Pokemon.all
    end

    def find_by_id(id)
      Pokemon.find(id)
    end
  end
end
