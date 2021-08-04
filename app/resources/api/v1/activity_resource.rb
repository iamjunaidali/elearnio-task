module Api
  module V1
    class ActivityResource < BaseResource
      caching

      attributes :name
      has_one :course
    end
  end
end
