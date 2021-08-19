FactoryBot.define do
  factory :pokemon_move do
    name { "MyString" }
    damage_class { "MyString" }
    power { 1 }
    type { nil }
  end
end
