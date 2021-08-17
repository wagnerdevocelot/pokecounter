class Type < ApplicationRecord
    has_many :type_a, :class_name => "Type", :foreign_key => "type_a_id"
    has_many :type_b, :class_name => "Type", :foreign_key => "type_b_id"
    # define a has_many association for pokemons where the foreign key is type_a_id or type_b_id
    has_many :pokemon_a, :class_name => "Pokemon", :foreign_key => "type_a_id"
    has_many :pokemon_b, :class_name => "Pokemon", :foreign_key => "type_b_id"

    def same_type_pokemons
        self.pokemon_a + self.pokemon_b
    end

    def physical_sweeper_counter_order_a
        self.pokemon_a.order(defense: :desc, attack: :desc, hp: :desc, total: :desc)
    end

    def physical_sweeper_counter_order_b
        self.pokemon_b.order(defense: :desc, attack: :desc, hp: :desc, total: :desc)
    end

    def special_sweeper_counter_order_a
        self.pokemon_a.order(special_defense: :desc, special_attack: :desc, hp: :desc, total: :desc)
    end

    def special_sweeper_counter_order_b
        self.pokemon_b.order(special_defense: :desc, special_attack: :desc, hp: :desc, total: :desc)
    end

    def physical_tank_counter_order_a
        self.pokemon_a.order(special_attack: :desc, speed: :desc, hp: :desc, total: :desc)
    end

    def physical_tank_counter_order_b
        self.pokemon_b.order(special_attack: :desc, speed: :desc, hp: :desc, total: :desc)
    end

    def special_tank_counter_order_a
        self.pokemon_a.order(attack: :desc, speed: :desc, hp: :desc, total: :desc)
    end

    def special_tank_counter_order_b
        self.pokemon_b.order(attack: :desc, speed: :desc, hp: :desc, total: :desc)
    end
end
