class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validates :instructor_id, presence: true
end
