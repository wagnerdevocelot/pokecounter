class Type < ApplicationRecord
    has_many :type_a, :class_name => "Type", :foreign_key => "type_a_id"
    has_many :type_b, :class_name => "Type", :foreign_key => "type_b_id"
end
