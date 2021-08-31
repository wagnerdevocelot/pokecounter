# frozen_string_literal: true

module Repositories
  class PokemonRepository < Pokemon
    def get_all
      Pokemon.all
    end

    def find_by_id(id)
      Pokemon.find(id)
    end
  end
end
