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

# rake db:seed
