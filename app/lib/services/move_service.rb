module Services
    class MoveService < Move
        def move_repository_response(id)
            response = Repositories::MoveRepository.get_move(id)

            begin
                pokemon_move = Move.new
                pokemon_move.name = response["name"]
                pokemon_move.move_type = response["move_type"]
                pokemon_move.save
            rescue Exception => e
                puts e.message
            end

        end
    end
end

# res = Services::MoveService.new.move_repository_response(1)