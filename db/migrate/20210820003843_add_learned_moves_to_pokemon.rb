# frozen_string_literal: true

class AddLearnedMovesToPokemon < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :learned_moves, :string, array: true, default: []
  end
end
