class AddFormToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :form, :string
    add_column :pokemons, :total, :integer
    add_column :pokemons, :generation, :integer
  end
end
