FactoryBot.define do
  factory :pokemon do
    name { "MyString" }
    slot_a { "MyString" }
    slot_b { "MyString" }
    hp { 1 }
    attack { 1 }
    defense { 1 }
    special_attack { 1 }
    special_defense { 1 }
    speed { 1 }
    average_stats { 1 }
  end
end
