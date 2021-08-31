# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { 'MyString' }
    type_a { Type.create(name: 'MyString') }
    type_b { build(:type) }
    hp { 1 }
    attack { 1 }
    defense { 1 }
    special_attack { 1 }
    special_defense { 1 }
    speed { 1 }
    total { 1 }
    generation { 1 }
  end
end
