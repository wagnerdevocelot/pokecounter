# frozen_string_literal: true

module Repositories
  class TypeRepository
    require 'httparty'

    def self.get_type(type_id)
      res = HTTParty.get("http://pokeapi.co/api/v2/type/#{type_id}")

      {
        'name' => res['name'],
        'double_damage_from' => res['damage_relations']['double_damage_from'].map { |type| type['name'] },
        'half_damage_from' => res['damage_relations']['half_damage_from'].map { |type| type['name'] },
        'no_damage_from' => res['damage_relations']['no_damage_from'].map { |type| type['name'] },
        'double_damage_to' => res['damage_relations']['double_damage_to'].map { |type| type['name'] },
        'half_damage_to' => res['damage_relations']['half_damage_to'].map { |type| type['name'] },
        'no_damage_to' => res['damage_relations']['no_damage_to'].map { |type| type['name'] }
      }
    end
  end
end
