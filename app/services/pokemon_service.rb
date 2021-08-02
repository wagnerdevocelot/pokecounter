require_relative 'PokemonRepository'

module PokemonService
  extend PokemonRepository

  def self.create_pokemon(id)
      response = get_pokemon(id)
      puts response
  end
end

res = PokemonService.create_pokemon(1)
puts res







# def self.create_pokemon(id)
#   response = get_pokemon(id)

#   create_pokemon =  Pokemon.new

#   create_pokemon.name = response['name']
#   if response['types'].count == 2
#       create_pokemon.slot_a = response['types'][0]['type']['name']
#       create_pokemon.slot_b = response['types'][1]['type']['name']
#   else
#       create_pokemon.slot_a = response['types'][0]['type']['name']
#   end
#   create_pokemon.hp = response['stats'][0]['base_stat']
#   create_pokemon.attack = response['stats'][1]['base_stat']
#   create_pokemon.defense = response['stats'][2]['base_stat']
#   create_pokemon.special_attack = response['stats'][3]['base_stat']
#   create_pokemon.special_defense =  response['stats'][4]['base_stat']
#   create_pokemon.speed = response['stats'][5]['base_stat']
#   create_pokemon.average_stats = [create_pokemon.hp, create_pokemon.attack, create_pokemon.defense, create_pokemon.special_attack, create_pokemon.special_defense, create_pokemon.speed].sum / 6
#   if create_pokemon.save
#     puts "Successfully created pokemon #{create_pokemon.name}"
#   else
#     puts "Failed to create pokemon #{create_pokemon.name}"
#   end
# end