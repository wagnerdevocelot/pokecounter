class Pokemon < ApplicationRecord
  belongs_to :type_a, class_name: 'Type'
  belongs_to :type_b, class_name: 'Type'

  validates :type_a_id, presence: true
  validates :type_b_id, presence: false
end
