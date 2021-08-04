require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:activities) }
    it { should belong_to(:coach) }
  end
end
