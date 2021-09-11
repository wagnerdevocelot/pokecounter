# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::TypeRepository do
  type_normal = Type.create(name: 'normal', double_damage_from: ['fighting'], double_damage_to: [],
                            half_damage_from: [], half_damage_to: %w[rock steel], no_damage_from: ['ghost'], no_damage_to: ['ghost'])
  describe '#get_type' do
    it 'makes a request to the API and returns the type' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['name']).to eq(type_normal.name)
    end

    it 'returns the correct double damage from types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['double_damage_from']).to eq(type_normal.double_damage_from)
    end

    it 'returns the correct half damage from types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['half_damage_from']).to eq(type_normal.half_damage_from)
    end

    it 'returns the correct no damage from types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['no_damage_from']).to eq(type_normal.no_damage_from)
    end

    it 'returns the correct double damage to types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['double_damage_to']).to eq(type_normal.double_damage_to)
    end

    it 'returns the correct half damage to types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['half_damage_to']).to eq(type_normal.half_damage_to)
    end

    it 'returns the correct no damage to types' do
      type = Repositories::TypeRepository.get_type(1)

      expect(type['no_damage_to']).to eq(type_normal.no_damage_to)
    end
  end
end
