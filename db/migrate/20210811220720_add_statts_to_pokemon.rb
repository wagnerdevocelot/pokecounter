class AddStattsToPokemon < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :hp, :integer
    add_column :pokemons, :attack, :integer
    add_column :pokemons, :defense, :integer
    add_column :pokemons, :special_attack, :integer
    add_column :pokemons, :special_defense, :integer
    add_column :pokemons, :speed, :integer
  end
end
