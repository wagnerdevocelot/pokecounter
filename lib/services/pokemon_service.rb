# frozen_string_literal: true

module Services
  class PokemonService
    def get_all
      Repositories::PokemonRepository.new.get_all
    end

    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      pokemon_role = identify_role(pokemon.id)

      types = double_damage_counters(pokemon)
      types = half_damage_counters(pokemon) if types.empty?
      types = no_damage_counters(pokemon) if types.empty?

      counters = counter_sort(*types, :defense, :hp, :special_defense) if pokemon_role == 'Phyiscal Sweeper'
      counters = counter_sort(*types, :special_defense, :hp, :defense) if pokemon_role == 'Special Sweeper'
      counters = counter_sort(*types, :attack, :speed, :hp) if pokemon_role == 'Special Tank'
      counters = counter_sort(*types, :special_attack, :speed, :hp) if pokemon_role == 'Physical Tank'
      counters = counter_sort(*types, :attack, :special_attack, :speed) if pokemon_role == 'General'

      counters.first(30)
    end

    def double_damage_counters(pokemon)
      if pokemon.type_b.nil?
        Type.select { |t| t.double_damage_to.include?(pokemon.type_a.name) }
      else
        Type.select do |t|
          t.double_damage_to.include?(pokemon.type_a.name) or t.double_damage_to.include?(pokemon.type_b.name)
        end
      end
    end

    def half_damage_counters(pokemon)
      if pokemon.type_b.nil?
        Type.select { |t| t.half_damage_from.include?(pokemon.type_a.name) }
      else
        Type.select do |t|
          t.half_damage_from.include?(pokemon.type_a.name) or t.half_damage_from.include?(pokemon.type_b.name)
        end
      end
    end

    def no_damage_counters(pokemon)
      if pokemon.type_b.nil?
        Type.select { |t| t.no_damage_from.include?(pokemon.type_a.name) }
      else
        Type.select do |t|
          t.no_damage_from.include?(pokemon.type_a.name) or t.no_damage_from.include?(pokemon.type_b.name)
        end
      end
    end

    def identify_role(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      stats = [pokemon.hp, pokemon.attack, pokemon.special_attack, pokemon.defense, pokemon.special_defense,
               pokemon.speed].max(2)

      if stats.include?(pokemon.attack) && stats.include?(pokemon.speed)
        'Physical Sweeper'
      elsif stats.include?(pokemon.special_attack) && stats.include?(pokemon.speed)
        'Special Sweeper'
      elsif stats.include?(pokemon.attack) && stats.include?(pokemon.defense)
        'Physical Tank'
      elsif stats.include?(pokemon.special_attack) && stats.include?(pokemon.defense)
        'Special Tank'
      else
        'General'
      end
    end

    def counter_sort(*types, sortA, sortB, sortC)
      counters = []
      types.each do |type|
        counters << type.pokemon_a.order(sortA, sortB, sortC)
        counters << type.pokemon_b.order(sortA, sortB, sortC) unless type.pokemon_b.nil?
      end
      counters.flatten!
      counters.sort_by(&:total).reverse
    end
  end
end
