
module PokemonRepository
    require 'httparty'

    def get_pokemon(id)
        res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}/")

        json = {
            'name' => res['name'],
            'type_slot_a' => res['types'][0]['type']['name'],
            'type_slot_b' => res['types'][1]['type']['name'],
            'hp' => res['stats'][0]['base_stat'],
            'attack' => res['stats'][1]['base_stat'],
            'special_attack' => res['stats'][3]['base_stat'],
            'defense' => res['stats'][2]['base_stat'],
            'special_defense' => res['stats'][4]['base_stat'],
            'speed' => res['stats'][5]['base_stat'],
            'average_stats' => (res['stats'][0]['base_stat'] + res['stats'][1]['base_stat'] + res['stats'][2]['base_stat'] + res['stats'][3]['base_stat'] + res['stats'][4]['base_stat'] + res['stats'][5]['base_stat']) / 6
        }
        return json

    end
end

