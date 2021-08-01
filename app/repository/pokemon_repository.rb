require 'httparty'

module PokemonRepository
    def self.get_pokemon(id)
        HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}/")
    end
end


# response['name']
# if response['types'].count == 2
#     response['types'][0]['type']['name']
#     response['types'][1]['type']['name']
# else
#     response['types'][0]['type']['name']
# end
# response['stats'][0]['base_stat']
# response['stats'][1]['base_stat']
# response['stats'][2]['base_stat']
# response['stats'][3]['base_stat']
# response['stats'][4]['base_stat']
# response['stats'][5]['base_stat']
