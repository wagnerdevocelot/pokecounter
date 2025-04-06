# frozen_string_literal: true

# Create Pokemon types first
pokemon_types = [
  { name: "normal", double_damage_from: ["fighting"], half_damage_from: [], no_damage_from: ["ghost"],
    double_damage_to: [], half_damage_to: ["rock", "steel"], no_damage_to: ["ghost"] },
  { name: "fire", double_damage_from: ["water", "ground", "rock"], half_damage_from: ["fire", "grass", "ice", "bug", "steel", "fairy"],
    no_damage_from: [], double_damage_to: ["grass", "ice", "bug", "steel"], half_damage_to: ["fire", "water", "rock", "dragon"], no_damage_to: [] },
  { name: "water", double_damage_from: ["electric", "grass"], half_damage_from: ["fire", "water", "ice", "steel"],
    no_damage_from: [], double_damage_to: ["fire", "ground", "rock"], half_damage_to: ["water", "grass", "dragon"], no_damage_to: [] },
  { name: "electric", double_damage_from: ["ground"], half_damage_from: ["electric", "flying", "steel"],
    no_damage_from: [], double_damage_to: ["water", "flying"], half_damage_to: ["electric", "grass", "dragon"], no_damage_to: ["ground"] },
  { name: "grass", double_damage_from: ["fire", "ice", "poison", "flying", "bug"], half_damage_from: ["water", "electric", "grass", "ground"],
    no_damage_from: [], double_damage_to: ["water", "ground", "rock"], half_damage_to: ["fire", "grass", "poison", "flying", "bug", "dragon", "steel"], no_damage_to: [] },
  { name: "ice", double_damage_from: ["fire", "fighting", "rock", "steel"], half_damage_from: ["ice"],
    no_damage_from: [], double_damage_to: ["grass", "ground", "flying", "dragon"], half_damage_to: ["fire", "water", "ice", "steel"], no_damage_to: [] },
  { name: "fighting", double_damage_from: ["flying", "psychic", "fairy"], half_damage_from: ["bug", "rock", "dark"],
    no_damage_from: [], double_damage_to: ["normal", "ice", "rock", "dark", "steel"], half_damage_to: ["poison", "flying", "psychic", "bug", "fairy"], no_damage_to: ["ghost"] },
  { name: "poison", double_damage_from: ["ground", "psychic"], half_damage_from: ["grass", "fighting", "poison", "bug", "fairy"],
    no_damage_from: [], double_damage_to: ["grass", "fairy"], half_damage_to: ["poison", "ground", "rock", "ghost"], no_damage_to: ["steel"] },
  { name: "ground", double_damage_from: ["water", "grass", "ice"], half_damage_from: ["poison", "rock"],
    no_damage_from: ["electric"], double_damage_to: ["fire", "electric", "poison", "rock", "steel"], half_damage_to: ["grass", "bug"], no_damage_to: ["flying"] },
  { name: "flying", double_damage_from: ["electric", "ice", "rock"], half_damage_from: ["grass", "fighting", "bug"],
    no_damage_from: ["ground"], double_damage_to: ["grass", "fighting", "bug"], half_damage_to: ["electric", "rock", "steel"], no_damage_to: [] },
  { name: "psychic", double_damage_from: ["bug", "ghost", "dark"], half_damage_from: ["fighting", "psychic"],
    no_damage_from: [], double_damage_to: ["fighting", "poison"], half_damage_to: ["psychic", "steel"], no_damage_to: ["dark"] },
  { name: "bug", double_damage_from: ["fire", "flying", "rock"], half_damage_from: ["grass", "fighting", "ground"],
    no_damage_from: [], double_damage_to: ["grass", "psychic", "dark"], half_damage_to: ["fire", "fighting", "poison", "flying", "ghost", "steel", "fairy"], no_damage_to: [] },
  { name: "rock", double_damage_from: ["water", "grass", "fighting", "ground", "steel"], half_damage_from: ["normal", "fire", "poison", "flying"],
    no_damage_from: [], double_damage_to: ["fire", "ice", "flying", "bug"], half_damage_to: ["fighting", "ground", "steel"], no_damage_to: [] },
  { name: "ghost", double_damage_from: ["ghost", "dark"], half_damage_from: ["poison", "bug"],
    no_damage_from: ["normal", "fighting"], double_damage_to: ["psychic", "ghost"], half_damage_to: ["dark"], no_damage_to: ["normal"] },
  { name: "dragon", double_damage_from: ["ice", "dragon", "fairy"], half_damage_from: ["fire", "water", "electric", "grass"],
    no_damage_from: [], double_damage_to: ["dragon"], half_damage_to: ["steel"], no_damage_to: ["fairy"] },
  { name: "dark", double_damage_from: ["fighting", "bug", "fairy"], half_damage_from: ["ghost", "dark"],
    no_damage_from: ["psychic"], double_damage_to: ["psychic", "ghost"], half_damage_to: ["fighting", "dark", "fairy"], no_damage_to: [] },
  { name: "steel", double_damage_from: ["fire", "fighting", "ground"], half_damage_from: ["normal", "grass", "ice", "flying", "psychic", "bug", "rock", "dragon", "steel", "fairy"],
    no_damage_from: ["poison"], double_damage_to: ["ice", "rock", "fairy"], half_damage_to: ["fire", "water", "electric", "steel"], no_damage_to: [] },
  { name: "fairy", double_damage_from: ["poison", "steel"], half_damage_from: ["fighting", "bug", "dark"],
    no_damage_from: ["dragon"], double_damage_to: ["fighting", "dragon", "dark"], half_damage_to: ["fire", "poison", "steel"], no_damage_to: [] }
]

pokemon_types.each do |type_data|
  type = Type.create!(type_data)
  puts "Created type: #{type.name}"
end

# Now create Pokemon
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
  
  # Find the type by name, case-insensitive
  type_a_name = dex['Type 1']&.downcase || dex['Type1']&.downcase
  type_b_name = dex['Type 2']&.downcase || dex['Type2']&.downcase
  
  search_type_a = Type.find_by(name: type_a_name)
  search_type_b = type_b_name.present? ? Type.find_by(name: type_b_name) : nil
  
  unless search_type_a
    puts "Warning: Type '#{type_a_name}' not found for Pokemon #{dex['Name']}"
    next
  end
  
  pokemon.type_a = search_type_a
  pokemon.type_b = search_type_b
  
  begin
    pokemon.save!
    puts "Seeded #{pokemon.name}!"
  rescue => e
    puts "Error seeding #{pokemon.name}: #{e.message}"
  end
end

# rake db:seed
