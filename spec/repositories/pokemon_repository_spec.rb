# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::PokemonRepository do
  describe '#get_all' do
    it 'retorna todos os pokemons' do
      # Criar alguns pokémons para o teste
      type = Type.create(name: "test_type")
      Pokemon.create(name: "Test Pokemon", type_a_id: type.id, hp: 100, attack: 100, defense: 100, 
                   special_attack: 100, special_defense: 100, speed: 100, generation: 1, total: 600)
      
      repository = Repositories::PokemonRepository.new
      result = repository.get_all
      expect(result.count).to be >= 1 # Deve retornar pelo menos o Pokémon que criamos
    end
  end

  describe '#find_by_id' do
    it 'retorna o pokemon com o id especificado' do
      # Criar um pokémon para o teste
      type = Type.create(name: "test_type")
      pokemon = Pokemon.create(name: "Test Pokemon", type_a_id: type.id, hp: 100, attack: 100, defense: 100, 
                              special_attack: 100, special_defense: 100, speed: 100, generation: 1, total: 600)
      
      repository = Repositories::PokemonRepository.new
      result = repository.find_by_id(pokemon.id)
      expect(result.id).to eq(pokemon.id)
    end
  end
end
