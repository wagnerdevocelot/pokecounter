# frozen_string_literal: true

nationaldex = JSON.parse(File.read('lib/seeds/json/nationaldex.json'))
nationaldex.each do |dex|
  pokemon = Pokemon.new
  pokemon.name = dex['Name']
  pokemon.form = dex['Form']
  pokemon.total = dex['Total']
  pokemon.hp = dex['HP']
  pokemon.attack = dex['Attack']
  pokemon.defense = dex['Defense']
  pokemon.special_attack = dex['Sp. Atk']
  pokemon.special_defense = dex['Sp. Def']
  pokemon.speed = dex['Speed']
  pokemon.generation = dex['Generation']
  search_type_a = Type.find_by(name: dex['Type1'].downcase)
  search_type_b = Type.find_by(name: dex['Type2'].downcase)
  pokemon.type_a = search_type_a
  pokemon.type_b = search_type_b
  pokemon.save!
  puts "Seeded #{pokemon.name}!"
end

moves = JSON.parse(File.read('lib/seeds/json/moves.json'))
moves.each do |move|
  pokemon_move = PokemonMove.new
  pokemon_move.name = move['identifier']
  pokemon_move.power = move['power']
  pokemon_move.damage_class = move['damage_class_id']
  pokemon_move.type_id = move['type_id']
  pokemon_move.save!
  puts "Seeded #{pokemon_move.name}!"
end

# rake db:seed
