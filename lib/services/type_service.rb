# frozen_string_literal: true

module Services
  class TypeService < Type
    def type_repository_response(id)
      response = Repositories::TypeRepository.get_type(id)

      begin
        pokemon_type = Type.new
        pokemon_type.name = response['name']
        pokemon_type.double_damage_from = response['double_damage_from']
        pokemon_type.double_damage_to = response['double_damage_to']
        pokemon_type.half_damage_from = response['half_damage_from']
        pokemon_type.half_damage_to = response['half_damage_to']
        pokemon_type.no_damage_from = response['no_damage_from']
        pokemon_type.no_damage_to = response['no_damage_to']
        pokemon_type.save
      rescue Exception => e
        puts e.message
      end
    end
  end
end
