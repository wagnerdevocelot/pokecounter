# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_20_003843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokemon_moves", force: :cascade do |t|
    t.string "name"
    t.string "damage_class"
    t.integer "power"
    t.bigint "type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type_id"], name: "index_pokemon_moves_on_type_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.bigint "type_a_id"
    t.bigint "type_b_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.string "form"
    t.integer "total"
    t.integer "generation"
    t.string "learned_moves", default: [], array: true
    t.index ["type_a_id"], name: "index_pokemons_on_type_a_id"
    t.index ["type_b_id"], name: "index_pokemons_on_type_b_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "double_damage_from", default: [], array: true
    t.string "double_damage_to", default: [], array: true
    t.string "half_damage_from", default: [], array: true
    t.string "half_damage_to", default: [], array: true
    t.string "no_damage_from", default: [], array: true
    t.string "no_damage_to", default: [], array: true
  end

  add_foreign_key "pokemon_moves", "types"
end
