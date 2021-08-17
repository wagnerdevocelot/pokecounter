module Services
  class PokemonService
    def get_all
      pokemons = Repositories::PokemonRepository.new.get_all()

      return pokemons
    end

    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      pokemon_role = identify_roles(pokemon.id)

      types = double_damage_counters(pokemon)
      types = half_damage_counters(pokemon) if types.empty?
      types = no_damage_counters(pokemon) if types.empty?

      counters = []

      types.each do |type|
        if pokemon_role == "Phyiscal Sweeper"
          counters << type.physical_sweeper_counter_order_a
          counters << type.physical_sweeper_counter_order_b unless type.pokemon_b.nil?
        elsif pokemon_role == "Special Sweeper"
          counters << type.special_sweeper_counter_order_a
          counters << type.special_sweeper_counter_order_b unless type.pokemon_b.nil?
        elsif pokemon_role == "Physical Tank"
          counters << type.physical_tank_counter_order_a
          counters << type.physical_tank_counter_order_b unless type.pokemon_b.nil?
        else
          counters << type.special_tank_counter_order_a
          counters << type.special_tank_counter_order_b unless type.pokemon_b.nil?
        end
        counters.flatten!
      end

      return counters.first(5)
    end

    def double_damage_counters(pokemon)
      if pokemon.type_b.nil?
        return Type.select { |t| t.double_damage_to.include?(pokemon.type_a.name) }
      else
        return Type.select { |t| t.double_damage_to.include?(pokemon.type_a.name) or t.double_damage_to.include?(pokemon.type_b.name) }
      end
    end

    def half_damage_counters(pokemon)
      if pokemon.type_b.nil?
        return Type.select { |t| t.half_damage_from.include?(pokemon.type_a.name) }
      else
        return Type.select { |t| t.half_damage_from.include?(pokemon.type_a.name) or t.half_damage_from.include?(pokemon.type_b.name) }
      end
    end

    def no_damage_counters(pokemon)
      if pokemon.type_b.nil?
        return Type.select { |t| t.no_damage_from.include?(pokemon.type_a.name) }
      else
        return Type.select { |t| t.no_damage_from.include?(pokemon.type_a.name) or t.no_damage_from.include?(pokemon.type_b.name) }
      end
    end

    def identify_roles(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      stats = [pokemon.hp, pokemon.attack , pokemon.special_attack, pokemon.defense, pokemon.special_defense,  pokemon.speed ].max(2)

      case stats
      when stats.include?(pokemon.attack) && stats.include?(pokemon.speed)
        return "Physical Sweeper"
      when stats.include?(pokemon.special_attack) && stats.include?(pokemon.speed)
        return "Special Sweeper"
      when stats.include?(pokemon.attack) && stats.include?(pokemon.defense)
        return "Physical Tank"
      when stats.include?(pokemon.special_attack) && stats.include?(pokemon.defense)
        return "Special Tank"
      end
    end

  end
end


