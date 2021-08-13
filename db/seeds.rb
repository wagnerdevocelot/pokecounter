# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# {
#     "ID": 1,
#     "Name": "Bulbasaur",
#     "Form": " ",
#     "Type1": "Grass",
#     "Type2": "Poison",
#     "Total": 318,
#     "HP": 45,
#     "Attack": 49,
#     "Defense": 49,
#     "Sp. Atk": 65,
#     "Sp. Def": 65,
#     "Speed": 45,
#     "Generation": 1
#   },

nationaldex = JSON.parse(File.read("lib/seeds/json/nationaldex.json"))
nationaldex.each do |dex|
    pokemon = Pokemon.new
    pokemon.name = dex["Name"]
    pokemon.form = dex["Form"]
    pokemon.total = dex["Total"]
    pokemon.hp = dex["HP"]
    pokemon.attack = dex["Attack"]
    pokemon.defense = dex["Defense"]
    pokemon.special_attack = dex["Sp. Atk"]
    pokemon.special_defense = dex["Sp. Def"]
    pokemon.speed = dex["Speed"]
    pokemon.generation = dex["Generation"]
    search_type_a = Type.find_by(name: dex["Type1"].downcase)
    search_type_b = Type.find_by(name: dex["Type2"].downcase)
    if search_type_b.nil?
        pokemon.type_a = search_type_a
        pokemon.type_b = Type.find_by(name: "empty")
    else
        pokemon.type_a = search_type_a
        pokemon.type_b = search_type_b
    end
    pokemon.save!
    puts "Seeded #{pokemon.name}!"
end

# rake db:seed

