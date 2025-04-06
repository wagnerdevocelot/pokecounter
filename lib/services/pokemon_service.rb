# frozen_string_literal: true

module Services
  # PokemonService faz a requisicao de dados do servico Pokemon
  class PokemonService
    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      pokemon_role = identify_role(pokemon.id)

      # Verifica se o Pokémon tem tipo secundário
      type_b_name = pokemon.type_b&.name
      types = type_counters(pokemon.type_a.name, type_b_name)

      counters = role_selector(pokemon_role, types)
      counters.reject! { |counter| counter[:total] < pokemon.total }
    end

    def non_legendary_counter(id)
      counters = find_counter(id)
      counters.reject! { |counter| counter[:total] > 700 }
    end

    def role_selector(pokemon_role, types)
      case pokemon_role
      when 'Physical Sweeper'
        counter_sort(*types, :defense, :hp, :special_defense)
      when 'Special Sweeper'
        counter_sort(*types, :special_defense, :hp, :defense)
      when 'Physical Tank'
        counter_sort(*types, :attack, :speed, :hp)
      when 'Special Tank'
        counter_sort(*types, :special_attack, :speed, :hp)
      else
        counter_sort(*types, :attack, :special_attack, :speed)
      end
    end

    def type_counters(type_a, type_b)
      types_to_check = type_b.nil? ? [type_a] : [type_a, type_b]

      Type.select do |type|
        (type.double_damage_to + type.half_damage_to + type.no_damage_to & types_to_check).any?
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

    def counter_sort(*types, sort_a, sort_b, sort_c)
      counters = []
      types.each do |type|
        counters << type.pokemon_a.order(sort_a, sort_b, sort_c)
        counters << type.pokemon_b.order(sort_a, sort_b, sort_c) unless type.pokemon_b.nil?
      end
      counters.flatten!
      counters.sort_by(&:total).reverse
    end
  end
end
