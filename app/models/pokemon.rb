# frozen_string_literal: true

class Pokemon < ApplicationRecord
  belongs_to :type_a, class_name: 'Type'
  belongs_to :type_b, class_name: 'Type', optional: true
  validates :type_a_id, :name,  :hp, :attack, :defense, :special_attack, :special_defense, :speed, :total, :generation,
            presence: true
end
