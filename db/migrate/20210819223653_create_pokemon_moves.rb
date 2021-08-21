class CreatePokemonMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_moves do |t|
      t.string :name
      t.string :damage_class
      t.integer :power
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
