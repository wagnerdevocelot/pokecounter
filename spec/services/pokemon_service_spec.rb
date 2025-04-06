# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::PokemonService do
  let(:service) { Services::PokemonService.new }

  before do
    type_normal = Type.create(name: 'normal', double_damage_from: ['fighting'], double_damage_to: [],
                              half_damage_from: [], half_damage_to: %w[rock steel], no_damage_from: ['ghost'], no_damage_to: ['ghost'])
    type_fire = Type.create(name: 'fire', double_damage_from: %w[water ground rock], double_damage_to: %w[grass ice bug steel],
                            half_damage_from: %w[fire grass ice bug steel fairy], half_damage_to: %w[fire water rock dragon], no_damage_from: [], no_damage_to: [])
    type_water = Type.create(name: 'water', double_damage_from: %w[electric grass], double_damage_to: %w[fire ground rock],
                             half_damage_from: %w[fire water ice steel], half_damage_to: %w[water grass dragon], no_damage_from: [], no_damage_to: [])
    
    1045.times do |i|
      Pokemon.new(name: "pokemon#{i}", type_a: type_normal, type_b: type_normal, hp: rand(1..100),
                  attack: rand(1..100), special_attack: rand(1..100), defense: rand(1..100), special_defense: rand(1..100), speed: rand(1..100)).save(validate: false)
    end
    
    # Adicionar Pokémon específicos para testes de team counters
    Pokemon.new(name: "pikachu", type_a: type_normal, hp: 35, attack: 55, special_attack: 50, 
                defense: 40, special_defense: 50, speed: 90, total: 320).save(validate: false)
    Pokemon.new(name: "charizard", type_a: type_fire, hp: 78, attack: 84, special_attack: 109, 
                defense: 78, special_defense: 85, speed: 100, total: 534).save(validate: false)
    Pokemon.new(name: "blastoise", type_a: type_water, hp: 79, attack: 83, special_attack: 85, 
                defense: 100, special_defense: 105, speed: 78, total: 530).save(validate: false)
  end

  describe '#get_all' do
    it 'returns all pokemons' do
      expect(Services::PokemonService.get_all.count).to eq(1048) # 1045 + 3 específicos
    end
  end
  
  describe '#find_team_counters' do
    context 'when a valid team is provided' do
      it 'returns a team of 6 counters' do
        # Criar um time de teste com os Pokémon específicos que adicionamos
        team = %w[pikachu charizard pokemon5 pokemon10 pokemon15 pokemon20]
        
        counters = service.find_team_counters(team)
        
        expect(counters).to be_an(Array)
        expect(counters.length).to eq(6) # Deve retornar exatamente 6 Pokémon
      end
      
      it 'returns different counters for each team member' do
        team = %w[pikachu charizard pokemon5 pokemon10 pokemon15 pokemon20]
        
        counters = service.find_team_counters(team)
        
        # Verificar se os counters são únicos (não duplicados)
        counter_ids = counters.map { |c| c[:id] }
        expect(counter_ids.uniq.length).to eq(counter_ids.length)
      end
    end
    
    context 'when an invalid team is provided' do
      it 'raises an error for teams with less than 6 Pokémon' do
        incomplete_team = %w[pikachu charizard]
        
        expect { service.find_team_counters(incomplete_team) }
          .to raise_error(RuntimeError, 'Um time completo precisa ter 6 Pokémon')
      end
      
      it 'raises an error when a Pokémon does not exist' do
        invalid_team = %w[pikachu charizard nonexistent pokemon10 pokemon15 pokemon20]
        
        expect { service.find_team_counters(invalid_team) }
          .to raise_error(RuntimeError, /Pokémon não encontrado: nonexistent/)
      end
    end
  end
end
