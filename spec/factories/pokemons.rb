FactoryBot.define do
  factory :pokemon do
    name { "MyString" }
    type_a { nil }
    type_b { nil }
    hp { 1 }
    attack { 1 }
    defense { 1 }
    special_attack { 1 }
    special_defense { 1 }
    speed { 1 }
  end
end
