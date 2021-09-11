# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::PokemonRepository do
  describe '#get_all' do
    it 'returns all pokemon' do
      pokemon = Repositories::PokemonRepository.new
      expect(pokemon.get_all).to eq(Pokemon.all)
    end
  end

  describe '#find_by_id' do
    it 'returns a pokemon by id' do
      types = Type.create(name: 'Fire')
      Pokemon.create(name: 'Calyrex', type_a: types, type_b: types, hp: 100, attack: 85, defense: 80,
                     special_attack: 165, special_defense: 100, speed: 150, form: 'Shadow Rider', total: 680, generation: 8, learned_moves: [])
      pokemon = Repositories::PokemonRepository.new
      expect(pokemon.find_by_id(1)).to eq(Pokemon.find(1))
    end
  end
end
