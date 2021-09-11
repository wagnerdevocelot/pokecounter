# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::PokemonService do
  let(:service) { Services::PokemonService.new }

  before do
    type_normal = Type.create(name: 'normal', double_damage_from: ['fighting'], double_damage_to: [],
                              half_damage_from: [], half_damage_to: %w[rock steel], no_damage_from: ['ghost'], no_damage_to: ['ghost'])
    1045.times do |i|
      Pokemon.new(name: "pokemon#{i}", type_a: type_normal, type_b: type_normal, hp: rand(1..100),
                  attack: rand(1..100), special_attack: rand(1..100), defense: rand(1..100), special_defense: rand(1..100), speed: rand(1..100)).save(validate: false)
    end
  end

  describe '#get_all' do
    it 'returns all pokemons' do
      expect(service.get_all.count).to eq(1045)
    end
  end
end
