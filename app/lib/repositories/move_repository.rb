module Repositories
    class MoveRepository
        require 'httparty'

        def self.get_move(type_id)
            res = HTTParty.get("http://pokeapi.co/api/v2/move/#{type_id}")

            return {
                'name' => res['name'],
                'move_type' => res['type']['name']
            }
        end
    end
end