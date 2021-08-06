module Services
    class PokemonService < Pokemon
        def pokemon_repository_response(id)
            response = Repositories::PokemonRepository.get_pokemon(id)

            begin
                pokemon = Pokemon.new
                pokemon.name = response['name']
                pokemon.slot_a = response['slot_a']
                pokemon.slot_b = response['slot_b']
                pokemon.hp = response['hp']
                pokemon.attack = response['attack']
                pokemon.special_attack = response['special_attack']
                pokemon.defense = response['defense']
                pokemon.special_defense = response['special_defense']
                pokemon.speed = response['speed']
                pokemon.average_stats = response['average_stats']
                pokemon.save
            rescue Exception => e
                puts e.message
            end

        end
    end
end

# res = Services::PokemonService.new.pokemon_repository_response(1)
