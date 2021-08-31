# frozen_string_literal: true

class Type < ApplicationRecord
  has_many :type_a, class_name: 'Type', foreign_key: 'type_a_id'
  has_many :type_b, class_name: 'Type', foreign_key: 'type_b_id'
  has_many :pokemon_a, class_name: 'Pokemon', foreign_key: 'type_a_id'
  has_many :pokemon_b, class_name: 'Pokemon', foreign_key: 'type_b_id'
  validates :name, presence: true
  validates :name, uniqueness: true
end
