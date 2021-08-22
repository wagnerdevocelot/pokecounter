class Type < ApplicationRecord
    has_many :type_a, :class_name => "Type", :foreign_key => "type_a_id"
    has_many :type_b, :class_name => "Type", :foreign_key => "type_b_id"
    has_many :pokemon_moves
    # define a has_many association for pokemons where the foreign key is type_a_id or type_b_id
    has_many :pokemon_a, :class_name => "Pokemon", :foreign_key => "type_a_id"
    has_many :pokemon_b, :class_name => "Pokemon", :foreign_key => "type_b_id"

    def same_type_pokemons
        self.pokemon_a + self.pokemon_b
    end

    def physical_sweeper_counter_order
        self.same_type_pokemons.sort_by { |pokemon| [ pokemon.defense, pokemon.hp, pokemon.total ] }.reverse
    end

    def special_sweeper_counter_order
        self.same_type_pokemons.sort_by { |pokemon| [ pokemon.special_defense, pokemon.hp, pokemon.total ] }.reverse
    end

    def physical_tank_counter_order
        self.same_type_pokemons.sort_by { |pokemon| [ pokemon.special_attack, pokemon.speed, pokemon.total ] }.reverse
    end

    def special_tank_counter_order
        self.same_type_pokemons.sort_by { |pokemon| [ pokemon.attack, pokemon.speed, pokemon.total ] }.reverse
    end

    def general_counter_order
        self.same_type_pokemons.sort_by { |pokemon| [ pokemon.total ] }.reverse
    end

end
