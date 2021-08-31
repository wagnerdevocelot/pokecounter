# frozen_string_literal: true

class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.references :type_a
      t.references :type_b

      t.timestamps
    end
  end
end
