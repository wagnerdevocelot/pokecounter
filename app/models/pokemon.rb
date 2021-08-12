class Pokemon < ApplicationRecord
  belongs_to :type_a, class_name: 'Type'
  belongs_to :type_b, class_name: 'Type'
end
