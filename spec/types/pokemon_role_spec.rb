# frozen_string_literal: true

require 'rails_helper'
require 'types/pokemon_role' # Ensure the module is loaded

RSpec.describe Types::PokemonRole do
  # Describes the behavior of the .identify method
  describe '.identify' do
    # Creates a Pokémon mock for testing
    # Use `build_stubbed` or `create` from FactoryBot if factories are configured
    # Or a simple OpenStruct/double as shown below:
    let(:pokemon_mock) { instance_double(Pokemon) }

    context 'when the Pokémon is a Physical Sweeper' do
      it 'returns :physical_sweeper' do
        # Configures the mock to simulate a Physical Sweeper (high Attack and Speed)
        allow(pokemon_mock).to receive_messages(
          hp: 100, attack: 150, special_attack: 80,
          defense: 90, special_defense: 85, speed: 140
        )
        expect(described_class.identify(pokemon_mock)).to eq(Types::PokemonRole::PHYSICAL_SWEEPER)
      end
    end

    context 'when the Pokémon is a Special Sweeper' do
      it 'returns :special_sweeper' do
        # Configures the mock to simulate a Special Sweeper (high Special Attack and Speed)
        allow(pokemon_mock).to receive_messages(
          hp: 100, attack: 80, special_attack: 150,
          defense: 90, special_defense: 85, speed: 140
        )
        expect(described_class.identify(pokemon_mock)).to eq(Types::PokemonRole::SPECIAL_SWEEPER)
      end
    end

    context 'when the Pokémon is a Physical Tank' do
      it 'returns :physical_tank' do
        # Configures the mock to simulate a Physical Tank (high Attack and Defense)
        allow(pokemon_mock).to receive_messages(
          hp: 120, attack: 140, special_attack: 70,
          defense: 130, special_defense: 80, speed: 60
        )
        expect(described_class.identify(pokemon_mock)).to eq(Types::PokemonRole::PHYSICAL_TANK)
      end
    end

    context 'when the Pokémon is a Special Tank' do
      it 'returns :special_tank' do
        # Configures the mock to simulate a Special Tank (high Special Attack and Special Defense)
        allow(pokemon_mock).to receive_messages(
          hp: 120, attack: 70, special_attack: 140,
          defense: 80, special_defense: 130, speed: 60 # Adjusted: high special_defense
        )
        expect(described_class.identify(pokemon_mock)).to eq(Types::PokemonRole::SPECIAL_TANK)
      end
    end

    context 'when the Pokémon does not fit specific roles' do
      it 'returns :general' do
        # Configures the mock with more balanced stats, avoiding specific triggers
        allow(pokemon_mock).to receive_messages(
          hp: 100, attack: 100, special_attack: 105, # special_attack ligeiramente maior
          defense: 100, special_defense: 100, speed: 95 # speed ligeiramente menor
        )
        expect(described_class.identify(pokemon_mock)).to eq(Types::PokemonRole::GENERAL)
      end
    end
  end

  # Add tests for SORT_ATTRIBUTES if necessary
  describe '::SORT_ATTRIBUTES' do
    it 'mapeia roles para os atributos corretos' do
      expect(described_class::SORT_ATTRIBUTES[Types::PokemonRole::PHYSICAL_SWEEPER]).to eq(%i[defense hp
                                                                                              special_defense])
      expect(described_class::SORT_ATTRIBUTES[Types::PokemonRole::SPECIAL_SWEEPER]).to eq(%i[special_defense hp
                                                                                             defense])
      expect(described_class::SORT_ATTRIBUTES[Types::PokemonRole::PHYSICAL_TANK]).to eq(%i[attack speed hp])
      expect(described_class::SORT_ATTRIBUTES[Types::PokemonRole::SPECIAL_TANK]).to eq(%i[special_attack speed hp])
      expect(described_class::SORT_ATTRIBUTES[Types::PokemonRole::GENERAL]).to eq(%i[attack special_attack speed])
    end
  end
end
