# frozen_string_literal: true

RSpec.describe UserSession, type: :model do
  context 'associations' do
    it { have_many_to_one :user }
  end

  context 'validations' do
    it { validate_presence :user_id }
  end
end
