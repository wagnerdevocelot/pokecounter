module TypeRepository
    require 'httparty'

    def self.get_type(type_id)
        res = HTTParty.get("http://pokeapi.co/api/v2/type/#{type_id}")

        json = {
            'name' => res['name'],
            'double_damage_from' => res['damage_relations']['double_damage_from'],
            'half_damage_from' => res['damage_relations']['half_damage_from'],
            'no_damage_from' => res['damage_relations']['no_damage_from'],
            'double_damage_to' => res['damage_relations']['double_damage_to'],
            'half_damage_to' => res['damage_relations']['half_damage_to'],
            'no_damage_to' => res['damage_relations']['no_damage_to'],
        }
        return json
    end

end


