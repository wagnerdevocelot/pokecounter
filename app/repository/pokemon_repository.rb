module PokemonRepository
    require 'httparty'

    def get_pokemon(id)
        HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}/")
    end
end


