# frozen_string_literal: true

module ResponseHelper
  def parsed_response
    JSON.parse(response.body)
  end
end
