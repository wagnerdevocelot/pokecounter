# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::PokemonRepository do
  describe '#get_all' do
    it 'retorna todos os pokemons' do
      repository = Repositories::PokemonRepository.new
      result = repository.get_all
      expect(result.count).to eq(1045)
    end
  end

  describe '#find_by_id' do
    it 'retorna o pokemon com o id especificado' do
      repository = Repositories::PokemonRepository.new
      result = repository.find_by_id(1)
      expect(result['id']).to eq('1')
    end
  end
end
