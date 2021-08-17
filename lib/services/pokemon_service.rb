module Services
  class PokemonService
    def get_all
      pokemons = Repositories::PokemonRepository.new.get_all()

      return pokemons
    end

    def find_counter(id)
      pokemon = Repositories::PokemonRepository.new.find_by_id(id)
      pokemon_role = identify_roles(pokemon.id)


      if pokemon.type_b.nil?
        types = Type.select { |t| t.double_damage_to.include?(pokemon.type_a.name) }
      else
        types = Type.select { |t| t.double_damage_to.include?(pokemon.type_a.name) or t.double_damage_to.include?(pokemon.type_b.name) }
      end

      counters = []

      types.each do |type|
        if pokemon_role == "Phyiscal Sweeper"
          counters << type.pokemon_a.order(attack: :desc, defense: :desc, hp: :desc, total: :desc)
          counters << type.pokemon_b.order(attack: :desc, defense: :desc, hp: :desc, total: :desc) unless type.pokemon_b.nil?
        elsif pokemon_role == "Special Sweeper"
          counters << type.pokemon_a.order(special_attack: :desc, special_defense: :desc, hp: :desc, total: :desc)
          counters << type.pokemon_b.order(special_attack: :desc, special_defense: :desc, hp: :desc, total: :desc) unless type.pokemon_b.nil?
        elsif pokemon_role == "Physical Tank"
          counters << type.pokemon_a.order(special_attack: :desc, speed: :desc, total: :desc)
          counters << type.pokemon_b.order(special_attack: :desc, speed: :desc, total: :desc) unless type.pokemon_b.nil?
        else
          counters << type.pokemon_a.order(attack: :desc, speed: :desc, total: :desc)
          counters << type.pokemon_b.order(attack: :desc, speed: :desc, total: :desc) unless type.pokemon_b.nil?
        end
        counters.flatten!
      end

      return counters.first(5)
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


