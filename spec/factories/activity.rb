# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    name { Faker::Name.name }
    course { create(:course) }
  end
end
