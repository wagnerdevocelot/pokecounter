module Services
    class PokemonService
        def call(id)
            res = Repositories::PokemonRepository.get_pokemon(id)

            puts res.inspect
        end
    end
end

res = Services::PokemonService.new.call(1)
puts res.inspect