# frozen_string_literal: true

require_relative '../types/pokemon_role' # Adds the dependency

module Services
  # PokemonService encapsulates Pokemon-related logic
  class PokemonService
    def initialize(repository: Repositories::PokemonRepository.new)
      @repository = repository
    end

    def self.get_all
      new.get_all
    end

    def get_all
      @repository.get_all
    end

    def find_counter(id)
      pokemon = @repository.find_by_id(id)
      # Uses the new module to identify the role
      pokemon_role = Types::PokemonRole.identify(pokemon)

      type_b_name = pokemon.type_b&.name
      types = type_counters(pokemon.type_a.name, type_b_name)

      # Uses the new module to get the sorting attributes
      sort_attributes = Types::PokemonRole::SORT_ATTRIBUTES[pokemon_role]
      counters = counter_sort(*types, *sort_attributes)

      counters.reject! { |counter| counter[:total] < pokemon.total }
    end

    def non_legendary_counter(id)
      counters = find_counter(id)
      counters.reject! { |counter| counter[:total] > 700 }
    end

    def find_team_counters(team_names)
      raise 'Um time completo precisa ter 6 Pokémon' if team_names.length != 6

      team = team_names.map do |name|
        pokemon = @repository.find_by_name(name)
        raise "Pokémon não encontrado: #{name}" if pokemon.nil?

        pokemon
      end

      all_counters = Pokemon.where.not(id: team.map(&:id))
                            .order(total: :desc)
                            .limit(20)
                            .to_a

      if all_counters.length < 6
        additional_counters = Pokemon.where.not(id: team.map(&:id) + all_counters.map(&:id))
                                     .limit(6 - all_counters.length)
        all_counters.concat(additional_counters)
      end

      all_counters.take(6)
    end

    def type_counters(type_a, type_b)
      types_to_check = type_b.nil? ? [type_a] : [type_a, type_b]

      Type.select do |type|
        (type.double_damage_to + type.half_damage_to + type.no_damage_to & types_to_check).any?
      end
    end

    def counter_sort(*types, sort_a, sort_b, sort_c)
      counters = []
      types.each do |type|
        # Ensures that the query is done correctly
        # Assuming that type.pokemon_a and type.pokemon_b return Active Record Relations
        counters << type.pokemon_a.order(sort_a => :desc, sort_b => :desc, sort_c => :desc)
        # Checks if pokemon_b exists before trying to access it
        counters << Array.wrap(type.pokemon_b&.order(sort_a => :desc, sort_b => :desc, sort_c => :desc))
      end
      # Uses flat_map to simplify and ensures they are arrays before concatenating
      counters = counters.flat_map(&:to_a)
      # Removes duplicates based on Pokemon ID
      counters.uniq!(&:id)
      # Sorts by total in descending order as before
      counters.sort_by(&:total).reverse
    end
  end
end
