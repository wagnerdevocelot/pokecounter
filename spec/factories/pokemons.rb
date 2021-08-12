FactoryBot.define do
  factory :pokemon do
    name { "MyString" }
<<<<<<< HEAD
    type_a { nil }
    type_b { nil }
=======
    slot_a { "MyString" }
    slot_b { "MyString" }
    hp { 1 }
    attack { 1 }
    defense { 1 }
    special_attack { 1 }
    special_defense { 1 }
    speed { 1 }
    average_stats { 1 }
>>>>>>> dd27ccc6537684031a451594a3165f0b4499437b
  end
end
