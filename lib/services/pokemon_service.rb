# frozen_string_literal: true

module Services
  # PokemonService faz a requisição de dados do serviço Pokemon
  class PokemonService
    def self.get_all
      Repositories::PokemonRepository.new.get_all
    end

    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      pokemon_role = identify_role(pokemon.id)
      types = type_counters(pokemon.type_a.name, pokemon.type_b.name)
      counters = role_selector(pokemon_role, types)
      counters.first(30)
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
      Type.select do |type|
        (type.double_damage_to + type.half_damage_to + type.no_damage_to & [type_a, type_b]).any?
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
