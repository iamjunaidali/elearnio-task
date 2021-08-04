class Coach < ApplicationRecord
  has_many :courses

  before_destroy :update_courses

  def destroy
    if Coach.where.not(id: id).count.zero? && courses.any?
      errors.add(:base, 'Cannot delete Coach with course')
      false
    else
      super
    end
  end

  private

  def update_courses
    return unless courses.any?

    coach = Coach.where.not(id: id).last
    courses.update_all(coach_id: coach.id)
  end
end
