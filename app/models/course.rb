class Course < ApplicationRecord
  belongs_to :coach
  has_many :activities
end
