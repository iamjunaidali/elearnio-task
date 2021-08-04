JSONAPI.configure do |config|
  config.resource_cache = Rails.cache
  config.default_paginator = :offset

  config.default_page_size = 10
  config.maximum_page_size = 20
end
