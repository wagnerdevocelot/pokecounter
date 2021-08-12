class AddDamageRelationToTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :types, :double_damage_from, :string, array: true, default: []
    add_column :types, :double_damage_to, :string, array: true, default: []
    add_column :types, :half_damage_from, :string, array: true, default: []
    add_column :types, :half_damage_to, :string, array: true, default: []
    add_column :types, :no_damage_from, :string, array: true, default: []
    add_column :types, :no_damage_to, :string, array: true, default: []
  end
end
