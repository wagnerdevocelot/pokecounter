# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it 'nationaldex.json must exist' do
    expect(File.exist?('lib/seeds/json/nationaldex.json')).to eq(true)
  end

  it 'moves.json must exist' do
    expect(File.exist?('lib/seeds/json/moves.json')).to eq(true)
  end

  it 'must nationaldex.json must have 1045 objects' do
    expect(JSON.parse(File.read('lib/seeds/json/nationaldex.json')).count).to eq(1045)
  end

  it 'must moves.json must have 826 objects' do
    expect(JSON.parse(File.read('lib/seeds/json/moves.json')).count).to eq(826)
  end

  it 'make shure that all pokemon have at least one type' do
    expect(Pokemon.where(type_a: nil).count).to eq(0)
  end

  it 'make shure that pokemon.errors is empty before seeding' do
    nationaldex = JSON.parse(File.read('lib/seeds/json/nationaldex.json'))
    pokemon = Pokemon.create(
      name: nationaldex[0]['Name'],
      form: nationaldex[0]['Form'],
      total: nationaldex[0]['Total'],
      hp: nationaldex[0]['HP'],
      attack: nationaldex[0]['Attack'],
      defense: nationaldex[0]['Defense'],
      special_attack: nationaldex[0]['Sp. Atk'],
      special_defense: nationaldex[0]['Sp. Def'],
      speed: nationaldex[0]['Speed'],
      generation: nationaldex[0]['Generation'],
      type_a: Type.create(name: nationaldex[0]['Type1']),
      type_b: Type.create(name: nationaldex[0]['Type2'])
    )

    expect(pokemon.errors.count).to eq(0)
  end
end
