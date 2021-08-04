module Api
  module V1
    class CoachResource < BaseResource
      caching

      attributes :name
      has_many :courses
    end
  end
end
