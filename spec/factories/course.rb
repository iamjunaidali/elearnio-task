# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    coach { create(:coach) }
  end
end
