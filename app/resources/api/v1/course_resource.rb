module Api
  module V1
    class CourseResource < BaseResource
      caching

      attributes :name, :self_assignable, :coach
      has_many :activities
      has_one :coach

      filter :self_assignable

      def coach
        @model.coach.name
      end
    end
  end
end
