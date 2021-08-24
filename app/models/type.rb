class Type < ApplicationRecord
    has_many :type_a, :class_name => "Type", :foreign_key => "type_a_id"
    has_many :type_b, :class_name => "Type", :foreign_key => "type_b_id"
    has_many :pokemon_moves
    # define a has_many association for pokemons where the foreign key is type_a_id or type_b_id
    has_many :pokemon_a, :class_name => "Pokemon", :foreign_key => "type_a_id"
    has_many :pokemon_b, :class_name => "Pokemon", :foreign_key => "type_b_id"
end

